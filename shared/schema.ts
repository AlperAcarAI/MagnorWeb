import { sql } from "drizzle-orm";
import { pgTable, text, varchar, integer, decimal, boolean, timestamp, jsonb, pgEnum, uuid, unique, index } from "drizzle-orm/pg-core";
import { relations } from "drizzle-orm";
import { createInsertSchema, createSelectSchema } from "drizzle-zod";
import { z } from "zod";

// ============================================================================
// ENUMS
// ============================================================================

export const userRoleEnum = pgEnum("user_role", ["admin", "user", "viewer"]);
export const proficiencyLevelEnum = pgEnum("proficiency_level", ["native", "fluent", "intermediate", "basic"]);

// ============================================================================
// AUTHENTICATION & USER MANAGEMENT TABLES
// ============================================================================

export const users = pgTable("users", {
  id: uuid("id").primaryKey().defaultRandom(),
  username: text("username").notNull().unique(),
  email: text("email").unique(),
  password: text("password").notNull(),
  role: userRoleEnum("role").notNull().default("user"),
  isActive: boolean("is_active").notNull().default(true),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
  lastLogin: timestamp("last_login"),
});

export const sessions = pgTable("sessions", {
  id: uuid("id").primaryKey().defaultRandom(),
  userId: uuid("user_id").notNull().references(() => users.id, { onDelete: "cascade" }),
  token: text("token").notNull().unique(),
  expiresAt: timestamp("expires_at").notNull(),
  createdAt: timestamp("created_at").notNull().defaultNow(),
}, (table) => ({
  userIdIdx: index("sessions_user_id_idx").on(table.userId),
}));

// ============================================================================
// KOL MANAGEMENT TABLES
// ============================================================================

export const kols = pgTable("kols", {
  id: uuid("id").primaryKey().defaultRandom(),
  name: text("name").notNull(),
  tierScore: integer("tier_score"),
  telegramAddress: text("telegram_address"),
  email: text("email"),
  phone: text("phone"),
  notes: text("notes"),
  isActive: boolean("is_active").notNull().default(true),
  createdBy: uuid("created_by").references(() => users.id),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
}, (table) => ({
  nameIdx: index("kols_name_idx").on(table.name),
  tierScoreIdx: index("kols_tier_score_idx").on(table.tierScore),
}));

export const socialMedia = pgTable("social_media", {
  id: uuid("id").primaryKey().defaultRandom(),
  name: text("name").notNull().unique(),
  icon: text("icon"),
  isActive: boolean("is_active").notNull().default(true),
});

export const kolSocialMedia = pgTable("kol_social_media", {
  id: uuid("id").primaryKey().defaultRandom(),
  kolId: uuid("kol_id").notNull().references(() => kols.id, { onDelete: "cascade" }),
  socialMediaId: uuid("social_media_id").notNull().references(() => socialMedia.id, { onDelete: "cascade" }),
  link: text("link").notNull(),
  followerCount: integer("follower_count"),
  engagementRate: decimal("engagement_rate", { precision: 5, scale: 2 }),
  verified: boolean("verified").notNull().default(false),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
}, (table) => ({
  kolIdIdx: index("kol_social_media_kol_id_idx").on(table.kolId),
  socialMediaIdIdx: index("kol_social_media_social_media_id_idx").on(table.socialMediaId),
  uniqueKolSocialLink: unique("unique_kol_social_link").on(table.kolId, table.socialMediaId, table.link),
}));

export const languages = pgTable("languages", {
  id: uuid("id").primaryKey().defaultRandom(),
  name: text("name").notNull().unique(),
  code: text("code").notNull().unique(), // ISO 639-1 code
  isActive: boolean("is_active").notNull().default(true),
});

export const kolLanguages = pgTable("kol_languages", {
  id: uuid("id").primaryKey().defaultRandom(),
  kolId: uuid("kol_id").notNull().references(() => kols.id, { onDelete: "cascade" }),
  languageId: uuid("language_id").notNull().references(() => languages.id, { onDelete: "cascade" }),
  proficiencyLevel: proficiencyLevelEnum("proficiency_level"),
}, (table) => ({
  kolIdIdx: index("kol_languages_kol_id_idx").on(table.kolId),
  uniqueKolLanguage: unique("unique_kol_language").on(table.kolId, table.languageId),
}));

export const categories = pgTable("categories", {
  id: uuid("id").primaryKey().defaultRandom(),
  name: text("name").notNull().unique(),
  description: text("description"),
  icon: text("icon"),
  isActive: boolean("is_active").notNull().default(true),
});

export const kolCategories = pgTable("kol_categories", {
  id: uuid("id").primaryKey().defaultRandom(),
  kolId: uuid("kol_id").notNull().references(() => kols.id, { onDelete: "cascade" }),
  categoryId: uuid("category_id").notNull().references(() => categories.id, { onDelete: "cascade" }),
  isPrimary: boolean("is_primary").notNull().default(false),
}, (table) => ({
  kolIdIdx: index("kol_categories_kol_id_idx").on(table.kolId),
  uniqueKolCategory: unique("unique_kol_category").on(table.kolId, table.categoryId),
}));

export const agencies = pgTable("agencies", {
  id: uuid("id").primaryKey().defaultRandom(),
  name: text("name").notNull().unique(),
  contactName: text("contact_name"),
  contactEmail: text("contact_email"),
  contactPhone: text("contact_phone"),
  commissionRate: decimal("commission_rate", { precision: 5, scale: 2 }),
  notes: text("notes"),
  isActive: boolean("is_active").notNull().default(true),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
});

export const kolAgencies = pgTable("kol_agencies", {
  id: uuid("id").primaryKey().defaultRandom(),
  kolId: uuid("kol_id").notNull().references(() => kols.id, { onDelete: "cascade" }),
  agencyId: uuid("agency_id").notNull().references(() => agencies.id, { onDelete: "cascade" }),
  startDate: timestamp("start_date"),
  endDate: timestamp("end_date"),
  isActive: boolean("is_active").notNull().default(true),
  contractNotes: text("contract_notes"),
}, (table) => ({
  kolIdIdx: index("kol_agencies_kol_id_idx").on(table.kolId),
}));

export const kolPricing = pgTable("kol_pricing", {
  id: uuid("id").primaryKey().defaultRandom(),
  kolId: uuid("kol_id").notNull().references(() => kols.id, { onDelete: "cascade" }),
  serviceName: text("service_name").notNull(),
  socialMediaDetails: jsonb("social_media_details"), // { "twitter": { "tweets": 3 }, "youtube": { "videos": 1 } }
  price: decimal("price", { precision: 10, scale: 2 }).notNull(),
  priceWithoutCommission: decimal("price_without_commission", { precision: 10, scale: 2 }),
  currency: text("currency").notNull().default("USD"),
  notes: text("notes"),
  contactInfo: text("contact_info"),
  isActive: boolean("is_active").notNull().default(true),
  validFrom: timestamp("valid_from"),
  validUntil: timestamp("valid_until"),
  createdBy: uuid("created_by").references(() => users.id),
  createdAt: timestamp("created_at").notNull().defaultNow(),
  updatedAt: timestamp("updated_at").notNull().defaultNow(),
}, (table) => ({
  kolIdIdx: index("kol_pricing_kol_id_idx").on(table.kolId),
}));

// ============================================================================
// EXISTING BRANDS TABLE (kept for compatibility)
// ============================================================================

export const brands = pgTable("brands", {
  id: uuid("id").primaryKey().defaultRandom(),
  name: text("name").notNull(),
  logo: text("logo"), // URL or base64
  color: text("color").notNull().default("bg-purple-500"),
  createdAt: timestamp("created_at").notNull().defaultNow(),
});

// ============================================================================
// RELATIONS
// ============================================================================

export const usersRelations = relations(users, ({ many }) => ({
  sessions: many(sessions),
  createdKols: many(kols),
  createdPricing: many(kolPricing),
}));

export const sessionsRelations = relations(sessions, ({ one }) => ({
  user: one(users, {
    fields: [sessions.userId],
    references: [users.id],
  }),
}));

export const kolsRelations = relations(kols, ({ one, many }) => ({
  creator: one(users, {
    fields: [kols.createdBy],
    references: [users.id],
  }),
  socialMedia: many(kolSocialMedia),
  languages: many(kolLanguages),
  categories: many(kolCategories),
  agencies: many(kolAgencies),
  pricing: many(kolPricing),
}));

export const socialMediaRelations = relations(socialMedia, ({ many }) => ({
  kols: many(kolSocialMedia),
}));

export const kolSocialMediaRelations = relations(kolSocialMedia, ({ one }) => ({
  kol: one(kols, {
    fields: [kolSocialMedia.kolId],
    references: [kols.id],
  }),
  socialMedia: one(socialMedia, {
    fields: [kolSocialMedia.socialMediaId],
    references: [socialMedia.id],
  }),
}));

export const languagesRelations = relations(languages, ({ many }) => ({
  kols: many(kolLanguages),
}));

export const kolLanguagesRelations = relations(kolLanguages, ({ one }) => ({
  kol: one(kols, {
    fields: [kolLanguages.kolId],
    references: [kols.id],
  }),
  language: one(languages, {
    fields: [kolLanguages.languageId],
    references: [languages.id],
  }),
}));

export const categoriesRelations = relations(categories, ({ many }) => ({
  kols: many(kolCategories),
}));

export const kolCategoriesRelations = relations(kolCategories, ({ one }) => ({
  kol: one(kols, {
    fields: [kolCategories.kolId],
    references: [kols.id],
  }),
  category: one(categories, {
    fields: [kolCategories.categoryId],
    references: [categories.id],
  }),
}));

export const agenciesRelations = relations(agencies, ({ many }) => ({
  kols: many(kolAgencies),
}));

export const kolAgenciesRelations = relations(kolAgencies, ({ one }) => ({
  kol: one(kols, {
    fields: [kolAgencies.kolId],
    references: [kols.id],
  }),
  agency: one(agencies, {
    fields: [kolAgencies.agencyId],
    references: [agencies.id],
  }),
}));

export const kolPricingRelations = relations(kolPricing, ({ one }) => ({
  kol: one(kols, {
    fields: [kolPricing.kolId],
    references: [kols.id],
  }),
  creator: one(users, {
    fields: [kolPricing.createdBy],
    references: [users.id],
  }),
}));

// ============================================================================
// ZOD VALIDATION SCHEMAS
// ============================================================================

// Users
export const insertUserSchema = createInsertSchema(users, {
  username: z.string().min(3).max(50),
  email: z.string().email().optional(),
  password: z.string().min(8),
  role: z.enum(["admin", "user", "viewer"]).optional(),
}).omit({ id: true, createdAt: true, updatedAt: true, lastLogin: true, isActive: true });

export const selectUserSchema = createSelectSchema(users);

// Sessions
export const insertSessionSchema = createInsertSchema(sessions).omit({ id: true, createdAt: true });
export const selectSessionSchema = createSelectSchema(sessions);

// KOLs
export const insertKolSchema = createInsertSchema(kols, {
  name: z.string().min(1).max(255),
  tierScore: z.number().int().min(1).max(10).optional(),
  telegramAddress: z.string().optional(),
  email: z.string().email().optional(),
  phone: z.string().optional(),
  notes: z.string().optional(),
}).omit({ id: true, createdAt: true, updatedAt: true, isActive: true });

export const selectKolSchema = createSelectSchema(kols);

// Social Media
export const insertSocialMediaSchema = createInsertSchema(socialMedia, {
  name: z.string().min(1).max(100),
  icon: z.string().optional(),
}).omit({ id: true, isActive: true });

export const selectSocialMediaSchema = createSelectSchema(socialMedia);

// KOL Social Media
export const insertKolSocialMediaSchema = createInsertSchema(kolSocialMedia, {
  link: z.string().url(),
  followerCount: z.number().int().min(0).optional(),
  engagementRate: z.string().optional(),
}).omit({ id: true, createdAt: true, updatedAt: true, verified: true });

export const selectKolSocialMediaSchema = createSelectSchema(kolSocialMedia);

// Languages
export const insertLanguageSchema = createInsertSchema(languages, {
  name: z.string().min(1).max(100),
  code: z.string().length(2), // ISO 639-1
}).omit({ id: true, isActive: true });

export const selectLanguageSchema = createSelectSchema(languages);

// KOL Languages
export const insertKolLanguageSchema = createInsertSchema(kolLanguages, {
  proficiencyLevel: z.enum(["native", "fluent", "intermediate", "basic"]).optional(),
}).omit({ id: true });

export const selectKolLanguageSchema = createSelectSchema(kolLanguages);

// Categories
export const insertCategorySchema = createInsertSchema(categories, {
  name: z.string().min(1).max(100),
  description: z.string().optional(),
  icon: z.string().optional(),
}).omit({ id: true, isActive: true });

export const selectCategorySchema = createSelectSchema(categories);

// KOL Categories
export const insertKolCategorySchema = createInsertSchema(kolCategories).omit({ id: true });
export const selectKolCategorySchema = createSelectSchema(kolCategories);

// Agencies
export const insertAgencySchema = createInsertSchema(agencies, {
  name: z.string().min(1).max(255),
  contactEmail: z.string().email().optional(),
  commissionRate: z.string().optional(),
}).omit({ id: true, createdAt: true, updatedAt: true, isActive: true });

export const selectAgencySchema = createSelectSchema(agencies);

// KOL Agencies
export const insertKolAgencySchema = createInsertSchema(kolAgencies).omit({ id: true, isActive: true });
export const selectKolAgencySchema = createSelectSchema(kolAgencies);

// KOL Pricing
export const insertKolPricingSchema = createInsertSchema(kolPricing, {
  serviceName: z.string().min(1).max(255),
  socialMediaDetails: z.record(z.any()).optional(),
  price: z.string(),
  priceWithoutCommission: z.string().optional(),
  currency: z.string().length(3).optional(),
  notes: z.string().optional(),
}).omit({ id: true, createdAt: true, updatedAt: true, isActive: true });

export const selectKolPricingSchema = createSelectSchema(kolPricing);

// Brands
export const insertBrandSchema = createInsertSchema(brands, {
  name: z.string().min(1),
  logo: z.string().optional(),
  color: z.string().optional(),
}).omit({ id: true, createdAt: true });

export const selectBrandSchema = createSelectSchema(brands);

// ============================================================================
// TYPESCRIPT TYPES
// ============================================================================

export type InsertUser = z.infer<typeof insertUserSchema>;
export type User = typeof users.$inferSelect;

export type InsertSession = z.infer<typeof insertSessionSchema>;
export type Session = typeof sessions.$inferSelect;

export type InsertKol = z.infer<typeof insertKolSchema>;
export type Kol = typeof kols.$inferSelect;

export type InsertSocialMedia = z.infer<typeof insertSocialMediaSchema>;
export type SocialMedia = typeof socialMedia.$inferSelect;

export type InsertKolSocialMedia = z.infer<typeof insertKolSocialMediaSchema>;
export type KolSocialMedia = typeof kolSocialMedia.$inferSelect;

export type InsertLanguage = z.infer<typeof insertLanguageSchema>;
export type Language = typeof languages.$inferSelect;

export type InsertKolLanguage = z.infer<typeof insertKolLanguageSchema>;
export type KolLanguage = typeof kolLanguages.$inferSelect;

export type InsertCategory = z.infer<typeof insertCategorySchema>;
export type Category = typeof categories.$inferSelect;

export type InsertKolCategory = z.infer<typeof insertKolCategorySchema>;
export type KolCategory = typeof kolCategories.$inferSelect;

export type InsertAgency = z.infer<typeof insertAgencySchema>;
export type Agency = typeof agencies.$inferSelect;

export type InsertKolAgency = z.infer<typeof insertKolAgencySchema>;
export type KolAgency = typeof kolAgencies.$inferSelect;

export type InsertKolPricing = z.infer<typeof insertKolPricingSchema>;
export type KolPricing = typeof kolPricing.$inferSelect;

export type InsertBrand = z.infer<typeof insertBrandSchema>;
export type Brand = typeof brands.$inferSelect;

// ============================================================================
// LEGACY INTERFACES (kept for backward compatibility)
// ============================================================================

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
