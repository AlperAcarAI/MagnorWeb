import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import { languages, categories } from "../shared/schema";
import * as schema from "../shared/schema";
import dotenv from "dotenv";

// Load environment variables
dotenv.config();

// Database connection
const connectionString = process.env.DATABASE_URL;

if (!connectionString) {
  throw new Error("DATABASE_URL environment variable is not set");
}

const client = postgres(connectionString);
const db = drizzle(client, { schema });

async function updateReferenceData() {
  console.log("🔄 Updating reference data (Languages & Categories)...\n");

  try {
    // 1. Update Languages
    console.log("🗑️  Deleting existing languages...");
    await db.delete(languages);
    console.log("✅ Existing languages deleted\n");

    console.log("🌍 Adding new languages...");
    await db.insert(languages).values([
      { name: "Turkish", code: "tr" },
      { name: "English", code: "en" },
      { name: "French", code: "fr" },
      { name: "Spanish", code: "es" },
      { name: "Russian", code: "ru" },
      { name: "Arabic", code: "ar" },
      { name: "Chinese", code: "zh" },
      { name: "Japanese", code: "ja" },
      { name: "Korean", code: "ko" },
      { name: "German", code: "de" },
      { name: "Italian", code: "it" },
      { name: "Vietnamese", code: "vi" },
      { name: "Brasilian", code: "pt-br" },
      { name: "Portuguese", code: "pt" },
      { name: "Colombia", code: "es-co" },
      { name: "Argentina", code: "es-ar" },
      { name: "Peru", code: "es-pe" },
      { name: "Mexico", code: "es-mx" },
      { name: "Indonesia", code: "id" },
      { name: "Polish", code: "pl" },
      { name: "Dutch", code: "nl" },
      { name: "Latam", code: "es-latam" },
    ]);
    console.log("✅ New languages added\n");

    // 2. Update Categories
    console.log("🗑️  Deleting existing categories...");
    await db.delete(categories);
    console.log("✅ Existing categories deleted\n");

    console.log("📂 Adding new categories...");
    await db.insert(categories).values([
      { name: "Invesment", description: "Investment opportunities and strategies", icon: "investment" },
      { name: "Trade", description: "Trading and market activities", icon: "trade" },
      { name: "Volume", description: "Volume generation campaigns", icon: "volume" },
      { name: "AirDrop", description: "Airdrop campaigns and distributions", icon: "airdrop" },
      { name: "Brand Awaraness", description: "Brand awareness and visibility", icon: "brand" },
      { name: "PreSale", description: "Pre-sale and early access campaigns", icon: "presale" },
      { name: "News", description: "News and announcements", icon: "news" },
      { name: "Education", description: "Educational content and tutorials", icon: "education" },
      { name: "Gaming", description: "Gaming and GameFi projects", icon: "gaming" },
      { name: "Solona", description: "Solana blockchain ecosystem", icon: "solana" },
    ]);
    console.log("✅ New categories added\n");

    console.log("🎉 Reference data update completed successfully!");
    console.log("\n📊 Summary:");
    console.log("\n🌍 Languages (22):");
    console.log("   1. Turkish");
    console.log("   2. English");
    console.log("   3. French");
    console.log("   4. Spanish");
    console.log("   5. Russian");
    console.log("   6. Arabic");
    console.log("   7. Chinese");
    console.log("   8. Japanese");
    console.log("   9. Korean");
    console.log("   10. German");
    console.log("   11. Italian");
    console.log("   12. Vietnamese");
    console.log("   13. Brasilian");
    console.log("   14. Portuguese");
    console.log("   15. Colombia");
    console.log("   16. Argentina");
    console.log("   17. Peru");
    console.log("   18. Mexico");
    console.log("   19. Indonesia");
    console.log("   20. Polish");
    console.log("   21. Dutch");
    console.log("   22. Latam");

    console.log("\n📂 Categories (10):");
    console.log("   1. Invesment");
    console.log("   2. Trade");
    console.log("   3. Volume");
    console.log("   4. AirDrop");
    console.log("   5. Brand Awaraness");
    console.log("   6. PreSale");
    console.log("   7. News");
    console.log("   8. Education");
    console.log("   9. Gaming");
    console.log("   10. Solona\n");

  } catch (error) {
    console.error("❌ Error updating reference data:", error);
    throw error;
  } finally {
    await client.end();
  }
}

// Run the update
updateReferenceData()
  .then(() => {
    console.log("✨ Update script finished");
    process.exit(0);
  })
  .catch((error) => {
    console.error("💥 Update script failed:", error);
    process.exit(1);
  });
