import XLSX from 'xlsx';
import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import { kols, kolPricing } from "../db";
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

async function importPricing() {
  console.log("💰 Excel'den KOL fiyatları import ediliyor...\n");

  try {
    // Read Excel file
    console.log("📖 Excel dosyası okunuyor...");
    const workbook = XLSX.readFile('attached_assets/Magnor Marketing.xlsx');
    
    // Read KOLs Prices sheet - İlk satır header olduğu için range ile 2. satırdan başlıyoruz
    const pricesSheet = workbook.Sheets['KOLs Prices'];
    const pricesData: any[] = XLSX.utils.sheet_to_json(pricesSheet, { 
      range: 1, // İkinci satırdan başla
      header: ['Kol', 'Social Media', 'Count', 'Price', 'PriceNoCom', 'Notes', 'Contact']
    });
    
    console.log(`✅ KOLs Prices: ${pricesData.length} satır\n`);

    // Load all KOLs to create a name->id map
    console.log("🔍 KOL'lar yükleniyor...");
    const allKols = await db.query.kols.findMany({
      where: eq(kols.isActive, true),
    });
    const kolMap = new Map(allKols.map(k => [k.name.toLowerCase(), k.id]));
    console.log(`✅ ${allKols.length} KOL yüklendi\n`);

    let imported = 0;
    let skipped = 0;
    let errors = 0;

    for (const row of pricesData) {
      try {
        const kolName = row['Kol'];
        if (!kolName || kolName.trim() === '') {
          skipped++;
          continue;
        }

        // Find KOL ID
        const kolId = kolMap.get(kolName.toLowerCase());
        if (!kolId) {
          console.log(`⚠️  KOL bulunamadı: ${kolName}`);
          skipped++;
          continue;
        }

        // Get pricing data
        const socialMedia = row['Social Media'] || 'Genel';
        const price = row['Price'] ? parseFloat(String(row['Price']).replace(/[^0-9.-]/g, '')) : null;
        const priceNoCom = row['PriceNoCom'] ? parseFloat(String(row['PriceNoCom']).replace(/[^0-9.-]/g, '')) : null;
        const notes = row['Notes'] || null;
        const contact = row['Contact'] || null;

        if (!price) {
          skipped++;
          continue;
        }

        // Parse social media details (örn: "Twitter x3, Youtube x1")
        let socialMediaDetails: any = {};
        if (socialMedia && socialMedia !== 'Genel') {
          const parts = String(socialMedia).split(',').map(p => p.trim());
          for (const part of parts) {
            const match = part.match(/(.+?)\s*x?(\d+)?/i);
            if (match) {
              const platform = match[1].trim();
              const count = match[2] ? parseInt(match[2]) : 1;
              socialMediaDetails[platform] = { count };
            }
          }
        }

        // Create pricing
        await db.insert(kolPricing).values({
          kolId: kolId,
          serviceName: socialMedia,
          socialMediaDetails: Object.keys(socialMediaDetails).length > 0 ? socialMediaDetails : null,
          price: price.toString(),
          priceWithoutCommission: priceNoCom ? priceNoCom.toString() : null,
          currency: 'USD',
          notes: notes,
          contactInfo: contact,
        });

        console.log(`  💰 ${kolName} - ${socialMedia}: $${price}`);
        imported++;

      } catch (error: any) {
        console.error(`  ❌ Hata: ${error.message}`);
        errors++;
      }
    }

    console.log("\n" + "=".repeat(50));
    console.log("🎉 Pricing import tamamlandı!");
    console.log("=".repeat(50));
    console.log(`✅ Başarıyla import edildi: ${imported} fiyat`);
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

importPricing()
  .then(() => {
    console.log("✨ Import script tamamlandı");
    process.exit(0);
  })
  .catch((error) => {
    console.error("💥 Import başarısız:", error);
    process.exit(1);
  });
