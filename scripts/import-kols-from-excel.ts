import XLSX from 'xlsx';
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import { kols, kolSocialMedia, kolLanguages, kolCategories, kolAgencies, socialMedia, languages, categories, agencies } from "../db";
import * as schema from "../shared/schema";
import dotenv from "dotenv";
import { eq } from "drizzle-orm";

// Load environment variables
dotenv.config();

// Database connection
const connectionString = process.env.DATABASE_URL;

if (!connectionString) {
  throw new Error("DATABASE_URL environment variable is not set");
}

const client = postgres(connectionString);
const db = drizzle(client, { schema });

// Helper function to parse tier score from star rating
function parseTierScore(tierScorePicture: any): number | null {
  if (!tierScorePicture) return null;
  const stars = String(tierScorePicture);
  const count = (stars.match(/★/g) || []).length;
  return count > 0 ? count : null;
}

// Helper function to extract social media platform from URL
function extractPlatform(url: string): string | null {
  if (!url) return null;
  url = url.toLowerCase();
  
  if (url.includes('x.com') || url.includes('twitter.com')) return 'X';
  if (url.includes('t.me') || url.includes('telegram')) return 'Telegram';
  if (url.includes('instagram.com')) return 'Instagram';
  if (url.includes('youtube.com')) return 'Youtube';
  if (url.includes('tiktok.com')) return 'Tiktok';
  
  return null;
}

async function importKOLs() {
  console.log("🔄 Starting KOL import from Excel...\n");

  try {
    // Read Excel file
    console.log("📖 Reading Excel file...");
    const workbook = XLSX.readFile('attached_assets/Magnor Marketing.xlsx');
    const mainDataSheet = workbook.Sheets['MainData'];
    const data: any[] = XLSX.utils.sheet_to_json(mainDataSheet);
    
    console.log(`✅ Found ${data.length} KOLs in Excel\n`);

    // Get reference data from database
    console.log("🔍 Loading reference data...");
    const allSocialMedia = await db.query.socialMedia.findMany({
      where: eq(socialMedia.isActive, true),
    });
    const allLanguages = await db.query.languages.findMany({
      where: eq(languages.isActive, true),
    });
    const allCategories = await db.query.categories.findMany({
      where: eq(categories.isActive, true),
    });
    const allAgencies = await db.query.agencies.findMany({
      where: eq(agencies.isActive, true),
    });
    console.log("✅ Reference data loaded\n");

    // Create lookup maps
    const languageMap = new Map(allLanguages.map(l => [l.name.toLowerCase(), l.id]));
    const categoryMap = new Map(allCategories.map(c => [c.name.toLowerCase(), c.id]));
    const agencyMap = new Map(allAgencies.map(a => [a.name.toLowerCase(), a.id]));
    const socialMediaMap = new Map(allSocialMedia.map(s => [s.name.toLowerCase(), s.id]));

    let imported = 0;
    let skipped = 0;
    let errors = 0;

    for (const row of data) {
      try {
        const kolName = row['Kols'];
        if (!kolName || kolName.trim() === '') {
          skipped++;
          continue;
        }

        console.log(`\n📝 Processing: ${kolName}`);

        // Parse tier score
        const tierScore = parseTierScore(row['Tier Score Picture']) || 
                         (row['Tier Score'] ? parseInt(row['Tier Score']) : null);

        // Extract contact info
        const telegramAddress = row['İletişim'] || null;

        // Create KOL
        const [newKol] = await db
          .insert(kols)
          .values({
            name: kolName,
            tierScore: tierScore,
            telegramAddress: telegramAddress,
            notes: null,
          })
          .returning();

        console.log(`  ✅ Created KOL: ${kolName} (ID: ${newKol.id})`);

        // Add social media
        const socialLink = row['Socials'];
        if (socialLink) {
          const platform = extractPlatform(String(socialLink));
          if (platform) {
            const platformId = socialMediaMap.get(platform.toLowerCase());
            if (platformId) {
              await db.insert(kolSocialMedia).values({
                kolId: newKol.id,
                socialMediaId: platformId,
                link: String(socialLink),
                followerCount: null,
              });
              console.log(`  📱 Added social media: ${platform}`);
            }
          }
        }

        // Add language
        const language = row['Language'];
        if (language) {
          const langId = languageMap.get(String(language).toLowerCase());
          if (langId) {
            await db.insert(kolLanguages).values({
              kolId: newKol.id,
              languageId: langId,
            });
            console.log(`  🌍 Added language: ${language}`);
          }
        }

        // Add categories
        const categoryStr = row['Category'];
        if (categoryStr) {
          const categoryNames = String(categoryStr).split(',').map(c => c.trim());
          for (const catName of categoryNames) {
            const catId = categoryMap.get(catName.toLowerCase());
            if (catId) {
              await db.insert(kolCategories).values({
                kolId: newKol.id,
                categoryId: catId,
              });
              console.log(`  📂 Added category: ${catName}`);
            }
          }
        }

        // Add agency
        const agency = row['Agency'];
        if (agency) {
          const agencyId = agencyMap.get(String(agency).toLowerCase());
          if (agencyId) {
            await db.insert(kolAgencies).values({
              kolId: newKol.id,
              agencyId: agencyId,
            });
            console.log(`  🏢 Added agency: ${agency}`);
          }
        }

        imported++;

      } catch (error: any) {
        console.error(`  ❌ Error processing ${row['Kols']}: ${error.message}`);
        errors++;
      }
    }

    console.log("\n" + "=".repeat(50));
    console.log("🎉 Import completed!");
    console.log("=".repeat(50));
    console.log(`✅ Successfully imported: ${imported} KOLs`);
    console.log(`⏭️  Skipped (empty): ${skipped} rows`);
    console.log(`❌ Errors: ${errors} rows`);
    console.log("=".repeat(50) + "\n");

  } catch (error: any) {
    console.error("❌ Fatal error during import:", error);
    throw error;
  } finally {
    await client.end();
  }
}

// Run the import
importKOLs()
  .then(() => {
    console.log("✨ Import script finished successfully");
    process.exit(0);
  })
  .catch((error) => {
    console.error("💥 Import script failed:", error);
    process.exit(1);
  });
