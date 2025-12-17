import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import { users } from "../shared/schema";
import * as schema from "../shared/schema";
import bcrypt from "bcryptjs";
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

async function createAdmin() {
  console.log("👤 Creating admin user...\n");

  try {
    // Şifreyi hash'le (bcrypt ile)
    const hashedPassword = await bcrypt.hash("admin", 10);

    // Admin kullanıcısını oluştur
    const [admin] = await db
      .insert(users)
      .values({
        username: "admin",
        email: "admin@magnor.com",
        password: hashedPassword,
        role: "admin",
        isActive: true,
      })
      .returning();

    console.log("✅ Admin user created successfully!");
    console.log("\n📋 Admin Credentials:");
    console.log("   Username: admin");
    console.log("   Email: admin@magnor.com");
    console.log("   Password: admin");
    console.log("   Role: admin");
    console.log(`   User ID: ${admin.id}`);
    console.log("\n⚠️  IMPORTANT: Change this password in production!");
    console.log("   This is a default password for development only.\n");

  } catch (error: any) {
    if (error.code === "23505") {
      // Unique constraint violation
      console.log("⚠️  Admin user already exists!");
      console.log("   Username 'admin' is already taken.");
      console.log("\n💡 Tip: If you want to reset the password, delete the existing user first.");
    } else {
      console.error("❌ Error creating admin user:", error);
      throw error;
    }
  } finally {
    await client.end();
  }
}

// Run the script
createAdmin()
  .then(() => {
    console.log("✨ Script finished");
    process.exit(0);
  })
  .catch((error) => {
    console.error("💥 Script failed:", error);
    process.exit(1);
  });
