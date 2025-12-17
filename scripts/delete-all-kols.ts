import { drizzle } from "drizzle-orm/postgres-js";
import postgres from "postgres";
import { kols } from "../db";
import * as schema from "../shared/schema";
import dotenv from "dotenv";

dotenv.config();

const connectionString = process.env.DATABASE_URL;

if (!connectionString) {
  throw new Error("DATABASE_URL environment variable is not set");
}

const client = postgres(connectionString);
const db = drizzle(client, { schema });

async function deleteAllKOLs() {
  console.log("🗑️  Tüm KOL'lar siliniyor...\n");

  try {
    const result = await db.delete(kols);
    
    console.log("✅ Tüm KOL'lar ve ilişkili veriler başarıyla silindi!");
    console.log("   (İlişkili tablolar CASCADE ile otomatik temizlendi)\n");
    
  } catch (error: any) {
    console.error("❌ Silme hatası:", error);
    throw error;
  } finally {
    await client.end();
  }
}

deleteAllKOLs()
  .then(() => {
    console.log("✨ Silme işlemi tamamlandı");
    process.exit(0);
  })
  .catch((error) => {
    console.error("💥 Silme işlemi başarısız:", error);
    process.exit(1);
  });
