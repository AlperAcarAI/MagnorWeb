# Magnor DB - Database Design Documentation

Bu dokümantasyon, Magnor KOL (Key Opinion Leader) Yönetim Sistemi için tasarlanan PostgreSQL veritabanının yapısını açıklamaktadır.

## 📋 İçindekiler

1. [Genel Bakış](#genel-bakış)
2. [Veritabanı Mimarisi](#veritabanı-mimarisi)
3. [Tablo Yapıları](#tablo-yapıları)
4. [İlişkiler (Relations)](#i̇lişkiler)
5. [Kurulum Talimatları](#kurulum-talimatları)
6. [Seed Data](#seed-data)
7. [Kullanım Örnekleri](#kullanım-örnekleri)

---

## 🎯 Genel Bakış

Magnor DB, KOL'ların (Key Opinion Leaders) yönetimi için tasarlanmış, normalize edilmiş bir PostgreSQL veritabanıdır. Sistem aşağıdaki ana fonksiyonları sağlar:

- ✅ Kullanıcı kimlik doğrulama ve yetkilendirme
- ✅ KOL profil yönetimi
- ✅ Sosyal medya hesaplarının takibi
- ✅ Çok dilli destek
- ✅ Kategori bazlı sınıflandırma
- ✅ Ajans ilişkileri yönetimi
- ✅ Fiyatlandırma ve paket yönetimi

---

## 🏗️ Veritabanı Mimarisi

### Teknoloji Stack'i

- **Database**: PostgreSQL
- **ORM**: Drizzle ORM
- **Validation**: Zod
- **Type Safety**: TypeScript

### Tablo Grupları

```
┌─────────────────────────────────────────────────────────────┐
│                   AUTHENTICATION LAYER                       │
│  ┌──────────┐              ┌──────────┐                     │
│  │  users   │──────────────│ sessions │                     │
│  └──────────┘              └──────────┘                     │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                    KOL MANAGEMENT LAYER                      │
│                        ┌──────────┐                         │
│                        │   kols   │                         │
│                        └─────┬────┘                         │
│              ┌────────┬──────┼──────┬────────┐             │
│              │        │      │      │        │             │
│    ┌─────────▼──┐ ┌──▼───┐ ┌▼────┐ ┌▼──────┐ ┌▼────────┐ │
│    │kol_social_ │ │kol_  │ │kol_ │ │kol_   │ │kol_     │ │
│    │   media    │ │lang  │ │cat  │ │agency │ │pricing  │ │
│    └─────┬──────┘ └──┬───┘ └┬────┘ └┬──────┘ └─────────┘ │
│          │           │      │       │                      │
│    ┌─────▼──────┐ ┌─▼──────▼┐   ┌─▼────────┐             │
│    │social_media│ │languages│   │ agencies │             │
│    │categories  │ └─────────┘   └──────────┘             │
│    └────────────┘                                          │
└─────────────────────────────────────────────────────────────┘
```

---

## 📊 Tablo Yapıları

### 1. Authentication & User Management

#### **users**
Sistem kullanıcıları ve kimlik doğrulama bilgileri.

| Alan | Tip | Açıklama |
|------|-----|----------|
| id | UUID | Primary key |
| username | TEXT | Kullanıcı adı (unique) |
| email | TEXT | E-posta adresi (unique, optional) |
| password | TEXT | Hash'lenmiş şifre |
| role | ENUM | Kullanıcı rolü (admin, user, viewer) |
| is_active | BOOLEAN | Aktif kullanıcı mı? |
| created_at | TIMESTAMP | Oluşturulma zamanı |
| updated_at | TIMESTAMP | Güncellenme zamanı |
| last_login | TIMESTAMP | Son giriş zamanı |

**Indexes:**
- `username` (unique)
- `email` (unique)

---

#### **sessions**
Kullanıcı oturum yönetimi (opsiyonel, gelişmiş güvenlik için).

| Alan | Tip | Açıklama |
|------|-----|----------|
| id | UUID | Primary key |
| user_id | UUID | Foreign key → users.id |
| token | TEXT | Oturum token'ı (unique) |
| expires_at | TIMESTAMP | Token geçerlilik süresi |
| created_at | TIMESTAMP | Oluşturulma zamanı |

**Indexes:**
- `user_id`
- `token` (unique)

---

### 2. KOL Management

#### **kols**
KOL'ların ana bilgileri.

| Alan | Tip | Açıklama |
|------|-----|----------|
| id | UUID | Primary key |
| name | TEXT | KOL adı |
| tier_score | INTEGER | Tier skoru (1-10) |
| telegram_address | TEXT | Telegram kullanıcı adı |
| email | TEXT | E-posta adresi |
| phone | TEXT | Telefon numarası |
| notes | TEXT | Notlar |
| is_active | BOOLEAN | Aktif KOL mı? |
| created_by | UUID | Foreign key → users.id |
| created_at | TIMESTAMP | Oluşturulma zamanı |
| updated_at | TIMESTAMP | Güncellenme zamanı |

**Indexes:**
- `name`
- `tier_score`

**Business Rules:**
- `tier_score` 1-10 arasında olmalı
- Her KOL'un en az bir sosyal medya hesabı olması önerilir

---

#### **social_media**
Sosyal medya platformları (Twitter, YouTube, vb.).

| Alan | Tip | Açıklama |
|------|-----|----------|
| id | UUID | Primary key |
| name | TEXT | Platform adı (unique) |
| icon | TEXT | İkon URL'i veya identifier |
| is_active | BOOLEAN | Aktif platform mı? |

**Örnek Veriler:**
```sql
INSERT INTO social_media (name, icon) VALUES
  ('Twitter', 'twitter-icon'),
  ('YouTube', 'youtube-icon'),
  ('Instagram', 'instagram-icon'),
  ('TikTok', 'tiktok-icon'),
  ('Telegram', 'telegram-icon');
```

---

#### **kol_social_media**
KOL'ların sosyal medya hesapları (Many-to-Many ilişki).

| Alan | Tip | Açıklama |
|------|-----|----------|
| id | UUID | Primary key |
| kol_id | UUID | Foreign key → kols.id |
| social_media_id | UUID | Foreign key → social_media.id |
| link | TEXT | Profil linki (URL) |
| follower_count | INTEGER | Takipçi sayısı |
| engagement_rate | DECIMAL(5,2) | Etkileşim oranı (%) |
| verified | BOOLEAN | Doğrulanmış hesap mı? |
| created_at | TIMESTAMP | Oluşturulma zamanı |
| updated_at | TIMESTAMP | Güncellenme zamanı |

**Constraints:**
- UNIQUE (kol_id, social_media_id, link)

**Indexes:**
- `kol_id`
- `social_media_id`

---

#### **languages**
Dil seçenekleri.

| Alan | Tip | Açıklama |
|------|-----|----------|
| id | UUID | Primary key |
| name | TEXT | Dil adı (unique) |
| code | TEXT | ISO 639-1 kodu (unique) |
| is_active | BOOLEAN | Aktif dil mı? |

**Örnek Veriler:**
```sql
INSERT INTO languages (name, code) VALUES
  ('Türkçe', 'tr'),
  ('English', 'en'),
  ('Русский', 'ru'),
  ('Español', 'es'),
  ('中文', 'zh');
```

---

#### **kol_languages**
KOL'ların konuştukları diller (Many-to-Many ilişki).

| Alan | Tip | Açıklama |
|------|-----|----------|
| id | UUID | Primary key |
| kol_id | UUID | Foreign key → kols.id |
| language_id | UUID | Foreign key → languages.id |
| proficiency_level | ENUM | Yeterlilik seviyesi (native, fluent, intermediate, basic) |

**Constraints:**
- UNIQUE (kol_id, language_id)

**Indexes:**
- `kol_id`

---

#### **categories**
KOL kategori/uzmanlık alanları.

| Alan | Tip | Açıklama |
|------|-----|----------|
| id | UUID | Primary key |
| name | TEXT | Kategori adı (unique) |
| description | TEXT | Kategori açıklaması |
| icon | TEXT | İkon URL'i |
| is_active | BOOLEAN | Aktif kategori mi? |

**Örnek Veriler:**
```sql
INSERT INTO categories (name, description) VALUES
  ('DeFi', 'Decentralized Finance'),
  ('NFT', 'Non-Fungible Tokens'),
  ('GameFi', 'Gaming & Finance'),
  ('Trading', 'Trading & Investment'),
  ('Metaverse', 'Virtual Worlds');
```

---

#### **kol_categories**
KOL'ların uzmanlık kategorileri (Many-to-Many ilişki).

| Alan | Tip | Açıklama |
|------|-----|----------|
| id | UUID | Primary key |
| kol_id | UUID | Foreign key → kols.id |
| category_id | UUID | Foreign key → categories.id |
| is_primary | BOOLEAN | Birincil kategori mi? |

**Constraints:**
- UNIQUE (kol_id, category_id)

**Indexes:**
- `kol_id`

**Business Rules:**
- Her KOL'un bir tane `is_primary = true` kategorisi olabilir

---

#### **agencies**
KOL ajansları/network'leri.

| Alan | Tip | Açıklama |
|------|-----|----------|
| id | UUID | Primary key |
| name | TEXT | Ajans adı (unique) |
| contact_name | TEXT | İletişim kişisi |
| contact_email | TEXT | İletişim e-postası |
| contact_phone | TEXT | İletişim telefonu |
| commission_rate | DECIMAL(5,2) | Komisyon oranı (%) |
| notes | TEXT | Notlar |
| is_active | BOOLEAN | Aktif ajans mı? |
| created_at | TIMESTAMP | Oluşturulma zamanı |
| updated_at | TIMESTAMP | Güncellenme zamanı |

---

#### **kol_agencies**
KOL-Ajans ilişkileri (Many-to-Many ilişki).

| Alan | Tip | Açıklama |
|------|-----|----------|
| id | UUID | Primary key |
| kol_id | UUID | Foreign key → kols.id |
| agency_id | UUID | Foreign key → agencies.id |
| start_date | TIMESTAMP | Başlangıç tarihi |
| end_date | TIMESTAMP | Bitiş tarihi |
| is_active | BOOLEAN | Aktif ilişki mi? |
| contract_notes | TEXT | Sözleşme notları |

**Indexes:**
- `kol_id`

**Business Rules:**
- Bir KOL'un aynı anda sadece bir aktif ajansı olabilir

---

#### **kol_pricing**
KOL fiyatlandırma ve paket bilgileri.

| Alan | Tip | Açıklama |
|------|-----|----------|
| id | UUID | Primary key |
| kol_id | UUID | Foreign key → kols.id |
| service_name | TEXT | Hizmet/paket adı |
| social_media_details | JSONB | Sosyal medya detayları |
| price | DECIMAL(10,2) | Fiyat |
| price_without_commission | DECIMAL(10,2) | Komisyonsuz fiyat |
| currency | TEXT | Para birimi (default: 'USD') |
| notes | TEXT | Notlar |
| contact_info | TEXT | İletişim bilgisi |
| is_active | BOOLEAN | Aktif fiyatlandırma mı? |
| valid_from | TIMESTAMP | Geçerlilik başlangıcı |
| valid_until | TIMESTAMP | Geçerlilik sonu |
| created_by | UUID | Foreign key → users.id |
| created_at | TIMESTAMP | Oluşturulma zamanı |
| updated_at | TIMESTAMP | Güncellenme zamanı |

**JSONB Örneği (social_media_details):**
```json
{
  "twitter": {
    "tweets": 3,
    "retweets": 5,
    "likes": 10
  },
  "youtube": {
    "videos": 1,
    "duration": "5-10 minutes"
  }
}
```

**Indexes:**
- `kol_id`

---

### 3. Legacy Tables

#### **brands**
Marka/partner logoları (mevcut sistem uyumluluğu için korunmuştur).

| Alan | Tip | Açıklama |
|------|-----|----------|
| id | UUID | Primary key |
| name | TEXT | Marka adı |
| logo | TEXT | Logo URL'i veya base64 |
| color | TEXT | Renk kodu |
| created_at | TIMESTAMP | Oluşturulma zamanı |

---

## 🔗 İlişkiler (Relations)

### One-to-Many İlişkiler

```
users (1) → (N) sessions
users (1) → (N) kols (created_by)
users (1) → (N) kol_pricing (created_by)
kols (1) → (N) kol_pricing
```

### Many-to-Many İlişkiler

```
kols ←→ social_media (kol_social_media tablosu üzerinden)
kols ←→ languages (kol_languages tablosu üzerinden)
kols ←→ categories (kol_categories tablosu üzerinden)
kols ←→ agencies (kol_agencies tablosu üzerinden)
```

---

## 🚀 Kurulum Talimatları

### 1. PostgreSQL Database Oluşturma

#### Opsiyyon A: Neon (Cloud PostgreSQL - Önerilen)

1. [Neon.tech](https://neon.tech) üzerinde ücretsiz hesap oluşturun
2. Yeni bir proje oluşturun (proje adı: `magnor-db`)
3. Connection string'i kopyalayın
4. `.env` dosyasını güncelleyin:

```bash
DATABASE_URL=postgresql://username:password@ep-xxx.region.neon.tech/magnordb?sslmode=require
```

#### Opsiyyon B: Local PostgreSQL

```bash
# PostgreSQL kur (macOS)
brew install postgresql@15
brew services start postgresql@15

# Database oluştur
createdb magnor_db

# .env dosyasını güncelle
DATABASE_URL=postgresql://localhost:5432/magnor_db
```

### 2. Migration'ları Çalıştırma

```bash
# Migration dosyalarını oluştur
npx drizzle-kit generate

# Migration'ları database'e uygula
npx drizzle-kit push

# Alternatif: migrate komutu
npx drizzle-kit migrate
```

### 3. Doğrulama

```bash
# Drizzle Studio'yu başlat (database GUI)
npx drizzle-kit studio
```

Tarayıcınızda `https://local.drizzle.studio` açılacak ve tablolarınızı görebilirsiniz.

---

## 🌱 Seed Data

Başlangıç verileri eklemek için bir seed script oluşturun:

**seed.ts** (örnek):

```typescript
import { db } from "./server/db";
import { socialMedia, languages, categories } from "./shared/schema";

async function seed() {
  // Sosyal medya platformları
  await db.insert(socialMedia).values([
    { name: "Twitter", icon: "twitter" },
    { name: "YouTube", icon: "youtube" },
    { name: "Instagram", icon: "instagram" },
    { name: "TikTok", icon: "tiktok" },
    { name: "Telegram", icon: "telegram" },
  ]);

  // Diller
  await db.insert(languages).values([
    { name: "Türkçe", code: "tr" },
    { name: "English", code: "en" },
    { name: "Русский", code: "ru" },
    { name: "Español", code: "es" },
  ]);

  // Kategoriler
  await db.insert(categories).values([
    { name: "DeFi", description: "Decentralized Finance" },
    { name: "NFT", description: "Non-Fungible Tokens" },
    { name: "GameFi", description: "Gaming & Finance" },
    { name: "Trading", description: "Trading & Investment" },
    { name: "Metaverse", description: "Virtual Worlds" },
  ]);

  console.log("Seed data inserted successfully!");
}

seed().catch(console.error);
```

Çalıştırma:
```bash
npx tsx seed.ts
```

---

## 💡 Kullanım Örnekleri

### Örnek 1: Yeni KOL Ekleme

```typescript
import { db } from "./server/db";
import { kols, kolSocialMedia } from "./shared/schema";

async function addKOL() {
  // KOL oluştur
  const [kol] = await db.insert(kols).values({
    name: "Crypto Expert",
    tierScore: 8,
    telegramAddress: "@cryptoexpert",
    email: "expert@crypto.com",
    createdBy: userId, // current user ID
  }).returning();

  // Sosyal medya ekle
  await db.insert(kolSocialMedia).values({
    kolId: kol.id,
    socialMediaId: twitterId, // Twitter platform ID
    link: "https://twitter.com/cryptoexpert",
    followerCount: 150000,
    verified: true,
  });
}
```

### Örnek 2: KOL'ları Tier'e Göre Listeleme

```typescript
import { db } from "./server/db";
import { kols } from "./shared/schema";
import { desc, eq } from "drizzle-orm";

async function getTopKOLs() {
  const topKols = await db
    .select()
    .from(kols)
    .where(eq(kols.isActive, true))
    .orderBy(desc(kols.tierScore))
    .limit(10);

  return topKols;
}
```

### Örnek 3: KOL'un Tüm Bilgilerini Çekme (Relational Queries)

```typescript
import { db } from "./server/db";
import { kols } from "./shared/schema";

async function getKOLDetails(kolId: string) {
  const kolWithRelations = await db.query.kols.findFirst({
    where: (kols, { eq }) => eq(kols.id, kolId),
    with: {
      socialMedia: {
        with: {
          socialMedia: true,
        },
      },
      languages: {
        with: {
          language: true,
        },
      },
      categories: {
        with: {
          category: true,
        },
      },
      agencies: {
        with: {
          agency: true,
        },
      },
      pricing: true,
    },
  });

  return kolWithRelations;
}
```

### Örnek 4: Kategori Bazlı Filtreleme

```typescript
import { db } from "./server/db";
import { kols, kolCategories, categories } from "./shared/schema";
import { eq, and } from "drizzle-orm";

async function getKOLsByCategory(categoryName: string) {
  const result = await db
    .select({
      kol: kols,
      category: categories,
    })
    .from(kols)
    .innerJoin(kolCategories, eq(kols.id, kolCategories.kolId))
    .innerJoin(categories, eq(kolCategories.categoryId, categories.id))
    .where(
      and(
        eq(categories.name, categoryName),
        eq(kols.isActive, true)
      )
    );

  return result;
}
```

### Örnek 5: Fiyatlandırma Paketi Ekleme

```typescript
import { db } from "./server/db";
import { kolPricing } from "./shared/schema";

async function addPricingPackage(kolId: string) {
  await db.insert(kolPricing).values({
    kolId,
    serviceName: "Premium Package",
    socialMediaDetails: {
      twitter: { tweets: 5, retweets: 10 },
      youtube: { videos: 2 },
    },
    price: "5000.00",
    priceWithoutCommission: "4500.00",
    currency: "USD",
    notes: "Includes video review and social promotion",
    validFrom: new Date(),
    validUntil: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000), // 30 days
    createdBy: userId,
  });
}
```

---

## 📈 Best Practices

### 1. Veri Bütünlüğü

- ✅ Her zaman foreign key constraints kullanın
- ✅ Unique constraints ile veri tekrarını engelleyin
- ✅ Soft delete için `is_active` flag'lerini tercih edin

### 2. Performance

- ✅ Sık kullanılan query'ler için index'ler ekleyin
- ✅ JSONB veriler için GIN index kullanın (büyük veriler için)
- ✅ Pagination kullanın (LIMIT/OFFSET)

### 3. Güvenlik

- ✅ Şifreleri asla plain text olarak saklamayın (bcrypt kullanın)
- ✅ SQL injection'a karşı parametrize query'ler kullanın (Drizzle ORM bunu otomatik yapar)
- ✅ Hassas verileri `.env` dosyasında tutun ve `.gitignore`'a ekleyin

### 4. Audit Trail

- ✅ `created_at`, `updated_at`, `created_by` alanlarını kullanın
- ✅ Önemli değişiklikleri log'layın

---

## 🔍 Troubleshooting

### Migration Hataları

```bash
# Migration'ları sıfırla (dikkatli kullanın!)
npx drizzle-kit drop

# Tekrar oluştur
npx drizzle-kit push
```

### Connection Hataları

1. `.env` dosyasında DATABASE_URL'in doğru olduğundan emin olun
2. PostgreSQL service'in çalıştığını kontrol edin
3. Network/firewall ayarlarını kontrol edin

### Type Hataları

```bash
# Schema değişiklikleri sonrası TypeScript tiplerini yenile
npm run build
```

---

## 📚 Kaynaklar

- [Drizzle ORM Dokümantasyonu](https://orm.drizzle.team/)
- [PostgreSQL Dokümantasyonu](https://www.postgresql.org/docs/)
- [Zod Validation](https://zod.dev/)
- [Neon Database](https://neon.tech/docs)

---

## 🤝 Katkıda Bulunma

Database schema'sında değişiklik yapmak için:

1. `shared/schema.ts` dosyasını güncelleyin
2. Migration oluşturun: `npx drizzle-kit generate`
3. Test edin: `npx drizzle-kit push`
4. Dokümantasyonu güncelleyin (bu dosya)

---

**Son Güncelleme:** 08.12.2025
**Versiyon:** 1.0.0
