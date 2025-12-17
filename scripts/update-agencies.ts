import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import { agencies } from "../shared/schema";
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

async function updateAgencies() {
  console.log("🔄 Updating agencies...\n");

  try {
    // 1. Delete existing agencies
    console.log("🗑️  Deleting existing agencies...");
    await db.delete(agencies);
    console.log("✅ Existing agencies deleted\n");

    // 2. Add new agencies
    console.log("🏢 Adding new agencies...");
    await db.insert(agencies).values([
      {
        name: "Magnor",
        contactName: null,
        contactEmail: null,
        contactPhone: null,
        commissionRate: null,
        notes: "Magnor Agency - Premium Web3 Marketing",
      },
      {
        name: "Markchain",
        contactName: null,
        contactEmail: null,
        contactPhone: null,
        commissionRate: null,
        notes: "Markchain - Blockchain Marketing Agency",
      },
      {
        name: "Tiko",
        contactName: null,
        contactEmail: null,
        contactPhone: null,
        commissionRate: null,
        notes: "Tiko Agency",
      },
      {
        name: "FainEra",
        contactName: null,
        contactEmail: null,
        contactPhone: null,
        commissionRate: null,
        notes: "FainEra - Digital Marketing",
      },
      {
        name: "Cmedia",
        contactName: null,
        contactEmail: null,
        contactPhone: null,
        commissionRate: null,
        notes: "Cmedia - Content & Marketing Agency",
      },
    ]);
    console.log("✅ New agencies added\n");

    console.log("🎉 Agencies update completed successfully!");
    console.log("\n📊 Added agencies:");
    console.log("   1. Magnor");
    console.log("   2. Markchain");
    console.log("   3. Tiko");
    console.log("   4. FainEra");
    console.log("   5. Cmedia\n");

  } catch (error) {
    console.error("❌ Error updating agencies:", error);
    throw error;
  } finally {
    await client.end();
  }
}

// Run the update
updateAgencies()
  .then(() => {
    console.log("✨ Update script finished");
    process.exit(0);
  })
  .catch((error) => {
    console.error("💥 Update script failed:", error);
    process.exit(1);
  });
