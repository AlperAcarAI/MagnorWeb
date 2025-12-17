import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import { socialMedia } from "../shared/schema";
import * as schema from "../shared/schema";
import dotenv from "dotenv";
import { sql } from "drizzle-orm";

// Load environment variables
dotenv.config();

// Database connection
const connectionString = process.env.DATABASE_URL;

if (!connectionString) {
  throw new Error("DATABASE_URL environment variable is not set");
}

const client = postgres(connectionString);
const db = drizzle(client, { schema });

async function updateSocialMedia() {
  console.log("🔄 Updating social media platforms...\n");

  try {
    // 1. Önce mevcut sosyal medya platformlarını sil
    console.log("🗑️  Deleting existing social media platforms...");
    await db.delete(socialMedia);
    console.log("✅ Existing platforms deleted\n");

    // 2. Yeni sosyal medya platformlarını ekle
    console.log("📱 Adding new social media platforms...");
    await db.insert(socialMedia).values([
      { name: "X", icon: "x" },
      { name: "Telegram", icon: "telegram" },
      { name: "Instagram", icon: "instagram" },
      { name: "Youtube", icon: "youtube" },
      { name: "Tiktok", icon: "tiktok" },
      { name: "Buy signal", icon: "signal" },
      { name: "Youtube integration", icon: "youtube-integration" },
      { name: "X Thread", icon: "x-thread" },
      { name: "X Quote", icon: "x-quote" },
      { name: "Youtube (2nd channel)", icon: "youtube-2" },
      { name: "Youtube integration (2nd channel)", icon: "youtube-integration-2" },
      { name: "IG Reels", icon: "ig-reels" },
      { name: "IG Story", icon: "ig-story" },
      { name: "IG Post", icon: "ig-post" },
      { name: "AMA", icon: "ama" },
      { name: "Giveaway", icon: "giveaway" },
    ]);
    console.log("✅ New social media platforms added\n");

    console.log("🎉 Social media update completed successfully!");
    console.log("\n📊 Added platforms:");
    console.log("   1. X");
    console.log("   2. Telegram");
    console.log("   3. Instagram");
    console.log("   4. Youtube");
    console.log("   5. Tiktok");
    console.log("   6. Buy signal");
    console.log("   7. Youtube integration");
    console.log("   8. X Thread");
    console.log("   9. X Quote");
    console.log("   10. Youtube (2nd channel)");
    console.log("   11. Youtube integration (2nd channel)");
    console.log("   12. IG Reels");
    console.log("   13. IG Story");
    console.log("   14. IG Post");
    console.log("   15. AMA");
    console.log("   16. Giveaway\n");

  } catch (error) {
    console.error("❌ Error updating social media:", error);
    throw error;
  } finally {
    await client.end();
  }
}

// Run the update
updateSocialMedia()
  .then(() => {
    console.log("✨ Update script finished");
    process.exit(0);
  })
  .catch((error) => {
    console.error("💥 Update script failed:", error);
    process.exit(1);
  });
