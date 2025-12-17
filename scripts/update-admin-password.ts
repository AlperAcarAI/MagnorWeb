import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import { users } from "../shared/schema";
import * as schema from "../shared/schema";
import bcrypt from "bcryptjs";
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

async function updateAdminPassword() {
  console.log("🔐 Updating admin password...\n");

  try {
    // Yeni şifreyi hash'le (bcrypt ile)
    const newPassword = "Magnor*54";
    const hashedPassword = await bcrypt.hash(newPassword, 10);

    // Admin kullanıcısını bul ve şifreyi güncelle
    const [updatedAdmin] = await db
      .update(users)
      .set({ 
        password: hashedPassword,
        updatedAt: new Date()
      })
      .where(eq(users.username, "admin"))
      .returning();

    if (!updatedAdmin) {
      console.log("❌ Admin user not found!");
      console.log("   Please make sure an admin user exists in the database.");
      return;
    }

    console.log("✅ Admin password updated successfully!");
    console.log("\n📋 Admin Credentials:");
    console.log("   Username: admin");
    console.log("   Email:", updatedAdmin.email);
    console.log("   Password: Magnor*54");
    console.log("   Role:", updatedAdmin.role);
    console.log(`   User ID: ${updatedAdmin.id}`);
    console.log(`   Updated At: ${updatedAdmin.updatedAt}`);
    console.log("\n✨ You can now log in with the new password!\n");

  } catch (error: any) {
    console.error("❌ Error updating admin password:", error);
    throw error;
  } finally {
    await client.end();
  }
}

// Run the script
updateAdminPassword()
  .then(() => {
    console.log("✨ Script finished");
    process.exit(0);
  })
  .catch((error) => {
    console.error("💥 Script failed:", error);
    process.exit(1);
  });
