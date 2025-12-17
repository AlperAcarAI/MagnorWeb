import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import {
  socialMedia,
  languages,
  categories,
  agencies,
  users,
} from "../shared/schema";
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

async function seed() {
  console.log("🌱 Starting database seeding...\n");

  try {
    // 1. Sosyal Medya Platformları
    console.log("📱 Seeding social media platforms...");
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
    console.log("✅ Social media platforms seeded\n");

    // 2. Diller
    console.log("🌍 Seeding languages...");
    await db.insert(languages).values([
      { name: "Türkçe", code: "tr" },
      { name: "English", code: "en" },
      { name: "Русский", code: "ru" },
      { name: "Español", code: "es" },
      { name: "中文", code: "zh" },
      { name: "日本語", code: "ja" },
      { name: "한국어", code: "ko" },
      { name: "Français", code: "fr" },
      { name: "Deutsch", code: "de" },
      { name: "Italiano", code: "it" },
      { name: "Português", code: "pt" },
      { name: "العربية", code: "ar" },
    ]);
    console.log("✅ Languages seeded\n");

    // 3. Kategoriler
    console.log("📂 Seeding categories...");
    await db.insert(categories).values([
      {
        name: "DeFi",
        description: "Decentralized Finance - Blockchain based financial services",
        icon: "defi",
      },
      {
        name: "NFT",
        description: "Non-Fungible Tokens - Digital collectibles and art",
        icon: "nft",
      },
      {
        name: "GameFi",
        description: "Gaming & Finance - Play-to-earn games",
        icon: "gamefi",
      },
      {
        name: "Trading",
        description: "Trading & Investment - Market analysis and trading strategies",
        icon: "trading",
      },
      {
        name: "Metaverse",
        description: "Virtual Worlds - Immersive digital experiences",
        icon: "metaverse",
      },
      {
        name: "Layer 1",
        description: "Base blockchain protocols",
        icon: "layer1",
      },
      {
        name: "Layer 2",
        description: "Scaling solutions for blockchains",
        icon: "layer2",
      },
      {
        name: "AI & ML",
        description: "Artificial Intelligence and Machine Learning in crypto",
        icon: "ai",
      },
      {
        name: "Meme Coins",
        description: "Community-driven cryptocurrency projects",
        icon: "meme",
      },
      {
        name: "Infrastructure",
        description: "Blockchain infrastructure and tools",
        icon: "infrastructure",
      },
    ]);
    console.log("✅ Categories seeded\n");

    // 4. Örnek Ajanslar
    console.log("🏢 Seeding agencies...");
    await db.insert(agencies).values([
      {
        name: "Crypto Influencers Network",
        contactName: "John Doe",
        contactEmail: "john@cryptoinfluencers.com",
        contactPhone: "+1-555-0101",
        commissionRate: "15.00",
        notes: "Premium KOL agency specializing in crypto space",
      },
      {
        name: "Blockchain Marketing Agency",
        contactName: "Jane Smith",
        contactEmail: "jane@blockchainmarketing.io",
        contactPhone: "+1-555-0102",
        commissionRate: "20.00",
        notes: "Full-service marketing agency for blockchain projects",
      },
      {
        name: "Web3 Talent Hub",
        contactName: "Mike Johnson",
        contactEmail: "mike@web3talent.com",
        contactPhone: "+1-555-0103",
        commissionRate: "18.00",
        notes: "Connects brands with top Web3 influencers",
      },
    ]);
    console.log("✅ Agencies seeded\n");

    // 5. Demo Admin User (opsiyonel - production'da kaldırın!)
    console.log("👤 Seeding demo admin user...");
    console.log("⚠️  WARNING: This creates a demo admin user. Remove this in production!\n");
    
    // Not: Gerçek uygulamada şifreyi hash'lemeniz gerekir (bcrypt)
    // Bu sadece seed amaçlı, production'da kullanmayın!
    await db.insert(users).values([
      {
        username: "admin",
        email: "admin@magnor.com",
        password: "CHANGE_THIS_PASSWORD", // Production'da bcrypt hash kullanın!
        role: "admin",
      },
      {
        username: "demo_user",
        email: "user@magnor.com", 
        password: "CHANGE_THIS_PASSWORD", // Production'da bcrypt hash kullanın!
        role: "user",
      },
    ]);
    console.log("✅ Demo users seeded (Remember to change passwords!)\n");

    console.log("🎉 Database seeding completed successfully!");
    console.log("\n📊 Summary:");
    console.log("   - 8 social media platforms");
    console.log("   - 12 languages");
    console.log("   - 10 categories");
    console.log("   - 3 demo agencies");
    console.log("   - 2 demo users (admin & user)");
    console.log("\n⚠️  Next Steps:");
    console.log("   1. Update admin password in production");
    console.log("   2. Remove demo users if not needed");
    console.log("   3. Add real agency data");
    console.log("   4. Configure authentication properly\n");

  } catch (error) {
    console.error("❌ Error seeding database:", error);
    throw error;
  } finally {
    await client.end();
  }
}

// ES modules support
seed()
  .then(() => {
    console.log("✨ Seed script finished");
    process.exit(0);
  })
  .catch((error) => {
    console.error("💥 Seed script failed:", error);
    process.exit(1);
  });
