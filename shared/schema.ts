import { sql } from "drizzle-orm";
import { pgTable, text, varchar } from "drizzle-orm/pg-core";
import { createInsertSchema } from "drizzle-zod";
import { z } from "zod";

export const users = pgTable("users", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  username: text("username").notNull().unique(),
  password: text("password").notNull(),
});

export const insertUserSchema = createInsertSchema(users).pick({
  username: true,
  password: true,
});

export type InsertUser = z.infer<typeof insertUserSchema>;
export type User = typeof users.$inferSelect;

export const brands = pgTable("brands", {
  id: varchar("id").primaryKey().default(sql`gen_random_uuid()`),
  name: text("name").notNull(),
  logo: text("logo"), // URL or base64
  color: text("color").notNull().default("bg-purple-500"),
  createdAt: text("created_at").default(sql`CURRENT_TIMESTAMP`),
});

export const insertBrandSchema = createInsertSchema(brands).pick({
  name: true,
  logo: true,
  color: true,
});

export type InsertBrand = z.infer<typeof insertBrandSchema>;
export type Brand = typeof brands.$inferSelect;

export interface KeyStrength {
  icon: string;
  title: string;
  description: string;
}

export interface Statistic {
  value: string;
  label: string;
}

export interface Partner {
  name: string;
  logo?: string;
}

export interface Service {
  icon: string;
  title: string;
  description: string;
}

export interface TokenBenefit {
  title: string;
  description: string;
}

export interface ProcessStep {
  number: number;
  title: string;
  description: string;
}

export interface ContactMethod {
  icon: string;
  label: string;
  value: string;
  link: string;
}
