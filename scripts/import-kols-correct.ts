import XLSX from 'xlsx';
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import { kols, kolSocialMedia, kolLanguages, kolCategories, kolAgencies, socialMedia, languages, categories, agencies } from "../db";
import * as schema from "../shared/schema";
import dotenv from "dotenv";
import { eq } from "drizzle-orm";

dotenv.config();

const connectionString = process.env.DATABASE_URL;

if (!connectionString) {
  throw new Error("DATABASE_URL environment variable is not set");
}

const client = postgres(connectionString);
const db = drizzle(client, { schema });

// Helper to parse tier score
function parseTierScore(tierScorePicture: any): number | null {
  if (!tierScorePicture) return null;
  const stars = String(tierScorePicture);
  const count = (stars.match(/★/g) || []).length;
  return count > 0 ? count : null;
}

// Helper to extract platform from URL
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

async function importKOLsCorrect() {
  console.log("🔄 Excel'den doğru veri eşleştirmesiyle KOL import ediliyor...\n");

  try {
    // Read Excel file
    console.log("📖 Excel dosyası okunuyor...");
    const workbook = XLSX.readFile('attached_assets/Magnor Marketing.xlsx');
    
    // Read MainData sheet
    const mainDataSheet = workbook.Sheets['MainData'];
    const mainData: any[] = XLSX.utils.sheet_to_json(mainDataSheet);
    
    // Read KOLs Prices sheet
    const pricesSheet = workbook.Sheets['KOLs Prices'];
    const pricesData: any[] = XLSX.utils.sheet_to_json(pricesSheet);
    
    console.log(`✅ MainData: ${mainData.length} satır`);
    console.log(`✅ KOLs Prices: ${pricesData.length} satır\n`);

    // Load reference data
    console.log("🔍 Referans veriler yükleniyor...");
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
    console.log("✅ Referans veriler yüklendi\n");

    // Create lookup maps
    const languageMap = new Map(allLanguages.map(l => [l.name.toLowerCase(), l.id]));
    const categoryMap = new Map(allCategories.map(c => [c.name.toLowerCase(), c.id]));
    const agencyMap = new Map(allAgencies.map(a => [a.name.toLowerCase(), a.id]));
    const socialMediaMap = new Map(allSocialMedia.map(s => [s.name.toLowerCase(), s.id]));

    // Create price lookup by KOL name
    const pricesByName = new Map();
    for (const priceRow of pricesData) {
      const kolName = priceRow['Kol'];
      if (!kolName) continue;
      
      if (!pricesByName.has(kolName)) {
        pricesByName.set(kolName, []);
      }
      pricesByName.get(kolName).push(priceRow);
    }

    let imported = 0;
    let skipped = 0;
    let errors = 0;

    for (const row of mainData) {
      try {
        // A sütunu: KOL adı
        const kolName = row['Kols'];
        if (!kolName || kolName.trim() === '') {
          skipped++;
          continue;
        }

        console.log(`\n📝 İşleniyor: ${kolName}`);

        // C sütunu: Tier Score
        const tierScore = parseTierScore(row['Tier Score Picture']) || 
                         (row['Tier Score'] ? parseInt(row['Tier Score']) : null);

        // H sütunu: Notlar
        const notes = row['İletişim'] || null;

        // Create KOL
        const [newKol] = await db
          .insert(kols)
          .values({
            name: kolName,
            tierScore: tierScore,
            telegramAddress: notes,
            notes: null,
          })
          .returning();

        console.log(`  ✅ KOL oluşturuldu (ID: ${newKol.id})`);

        // B sütunu: Sosyal medya linkleri (virgülle ayrılmış)
        const socialLinks = row['Socials'];
        if (socialLinks) {
          // Virgülle ayır ve her linki ayrı ekle
          const links = String(socialLinks).split(',').map(l => l.trim()).filter(l => l);
          for (const link of links) {
            const platform = extractPlatform(link);
            if (platform) {
              const platformId = socialMediaMap.get(platform.toLowerCase());
              if (platformId) {
                await db.insert(kolSocialMedia).values({
                  kolId: newKol.id,
                  socialMediaId: platformId,
                  link: link,
                  followerCount: null,
                });
                console.log(`  📱 Sosyal medya: ${platform} - ${link.substring(0, 30)}...`);
              }
            }
          }
        }

        // F sütunu: Dil
        const language = row['Language'];
        if (language) {
          const langId = languageMap.get(String(language).toLowerCase());
          if (langId) {
            await db.insert(kolLanguages).values({
              kolId: newKol.id,
              languageId: langId,
            });
            console.log(`  🌍 Dil: ${language}`);
          }
        }

        // E sütunu: Kategoriler
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
              console.log(`  📂 Kategori: ${catName}`);
            }
          }
        }

        // G sütunu: Ajans
        const agency = row['Agency'];
        if (agency) {
          const agencyId = agencyMap.get(String(agency).toLowerCase());
          if (agencyId) {
            await db.insert(kolAgencies).values({
              kolId: newKol.id,
              agencyId: agencyId,
            });
            console.log(`  🏢 Ajans: ${agency}`);
          }
        }

        // Fiyat bilgileri için notlara ekle (gelecekte ayrı tablo olacak)
        const prices = pricesByName.get(kolName) || [];
        if (prices.length > 0) {
          const priceInfo = prices.map((p: any) => {
            const parts = [];
            if (p['Social Media']) parts.push(`Platform: ${p['Social Media']}`);
            if (p['Price']) parts.push(`Fiyat: ${p['Price']}`);
            if (p['PriceNoCom']) parts.push(`Komisyonsuz: ${p['PriceNoCom']}`);
            return parts.join(', ');
          }).join(' | ');
          
          console.log(`  💰 Fiyat bilgisi: ${prices.length} kayıt`);
        }

        imported++;

      } catch (error: any) {
        console.error(`  ❌ Hata: ${error.message}`);
        errors++;
      }
    }

    console.log("\n" + "=".repeat(50));
    console.log("🎉 Import tamamlandı!");
    console.log("=".repeat(50));
    console.log(`✅ Başarıyla import edildi: ${imported} KOL`);
    console.log(`⏭️  Atlandı: ${skipped} satır`);
    console.log(`❌ Hatalar: ${errors} satır`);
    console.log("=".repeat(50) + "\n");

  } catch (error: any) {
    console.error("❌ Fatal error:", error);
    throw error;
  } finally {
    await client.end();
  }
}

importKOLsCorrect()
  .then(() => {
    console.log("✨ Import script tamamlandı");
    process.exit(0);
  })
  .catch((error) => {
    console.error("💥 Import başarısız:", error);
    process.exit(1);
  });
