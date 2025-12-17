import { Express, Request, Response } from "express";
import { db } from "../db";
import { kols, kolSocialMedia, kolLanguages, kolCategories, kolAgencies, kolPricing, socialMedia, languages, categories, agencies } from "../db";
import { eq, desc } from "drizzle-orm";

export function setupKolRoutes(app: Express) {
  
  // Get all KOLs
  app.get("/api/kols", async (req: Request, res: Response) => {
    try {
      const allKols = await db.query.kols.findMany({
        where: eq(kols.isActive, true),
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
        },
        orderBy: [desc(kols.createdAt)],
      });

      res.json({ kols: allKols });
    } catch (error) {
      console.error("Get KOLs error:", error);
      res.status(500).json({ message: "KOL'lar alınırken hata oluştu" });
    }
  });

  // Get single KOL by ID
  app.get("/api/kols/:id", async (req: Request, res: Response) => {
    try {
      const { id } = req.params;

      const kol = await db.query.kols.findFirst({
        where: eq(kols.id, id),
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

      if (!kol) {
        return res.status(404).json({ message: "KOL bulunamadı" });
      }

      res.json({ kol });
    } catch (error) {
      console.error("Get KOL error:", error);
      res.status(500).json({ message: "KOL alınırken hata oluştu" });
    }
  });

  // Create new KOL
  app.post("/api/kols", async (req: Request, res: Response) => {
    try {
      const {
        name,
        tierScore,
        telegramAddress,
        email,
        phone,
        notes,
        socialMediaAccounts,
        languageIds,
        categoryIds,
        agencyIds,
      } = req.body;

      // Validasyon
      if (!name) {
        return res.status(400).json({ message: "KOL adı gereklidir" });
      }

      // KOL oluştur
      const [newKol] = await db
        .insert(kols)
        .values({
          name,
          tierScore: tierScore || null,
          telegramAddress: telegramAddress || null,
          email: email || null,
          phone: phone || null,
          notes: notes || null,
          createdBy: null, // TODO: get from session
        })
        .returning();

      // Sosyal medya hesaplarını ekle
      if (socialMediaAccounts && Array.isArray(socialMediaAccounts)) {
        for (const account of socialMediaAccounts) {
          if (account.socialMediaId && account.link) {
            await db.insert(kolSocialMedia).values({
              kolId: newKol.id,
              socialMediaId: account.socialMediaId,
              link: account.link,
              followerCount: account.followerCount || null,
              verified: account.verified || false,
            });
          }
        }
      }

      // Dilleri ekle
      if (languageIds && Array.isArray(languageIds)) {
        for (const languageId of languageIds) {
          await db.insert(kolLanguages).values({
            kolId: newKol.id,
            languageId,
          });
        }
      }

      // Kategorileri ekle
      if (categoryIds && Array.isArray(categoryIds)) {
        for (const categoryId of categoryIds) {
          await db.insert(kolCategories).values({
            kolId: newKol.id,
            categoryId,
          });
        }
      }

      // Ajansları ekle
      if (agencyIds && Array.isArray(agencyIds)) {
        for (const agencyId of agencyIds) {
          await db.insert(kolAgencies).values({
            kolId: newKol.id,
            agencyId,
          });
        }
      }

      res.status(201).json({
        message: "KOL başarıyla oluşturuldu",
        kol: newKol,
      });
    } catch (error) {
      console.error("Create KOL error:", error);
      res.status(500).json({ message: "KOL oluşturulurken hata oluştu" });
    }
  });

  // Update KOL
  app.put("/api/kols/:id", async (req: Request, res: Response) => {
    try {
      const { id } = req.params;
      const {
        name,
        tierScore,
        telegramAddress,
        email,
        phone,
        notes,
      } = req.body;

      const [updatedKol] = await db
        .update(kols)
        .set({
          name,
          tierScore,
          telegramAddress,
          email,
          phone,
          notes,
          updatedAt: new Date(),
        })
        .where(eq(kols.id, id))
        .returning();

      if (!updatedKol) {
        return res.status(404).json({ message: "KOL bulunamadı" });
      }

      res.json({
        message: "KOL başarıyla güncellendi",
        kol: updatedKol,
      });
    } catch (error) {
      console.error("Update KOL error:", error);
      res.status(500).json({ message: "KOL güncellenirken hata oluştu" });
    }
  });

  // Delete KOL (soft delete)
  app.delete("/api/kols/:id", async (req: Request, res: Response) => {
    try {
      const { id } = req.params;

      const [deletedKol] = await db
        .update(kols)
        .set({
          isActive: false,
          updatedAt: new Date(),
        })
        .where(eq(kols.id, id))
        .returning();

      if (!deletedKol) {
        return res.status(404).json({ message: "KOL bulunamadı" });
      }

      res.json({ message: "KOL başarıyla silindi" });
    } catch (error) {
      console.error("Delete KOL error:", error);
      res.status(500).json({ message: "KOL silinirken hata oluştu" });
    }
  });

  // Get all social media platforms
  app.get("/api/social-media", async (req: Request, res: Response) => {
    try {
      const platforms = await db.query.socialMedia.findMany({
        where: eq(socialMedia.isActive, true),
      });

      res.json({ platforms });
    } catch (error) {
      console.error("Get social media error:", error);
      res.status(500).json({ message: "Sosyal medya platformları alınırken hata oluştu" });
    }
  });

  // Get all languages
  app.get("/api/languages", async (req: Request, res: Response) => {
    try {
      const allLanguages = await db.query.languages.findMany({
        where: eq(languages.isActive, true),
      });

      res.json({ languages: allLanguages });
    } catch (error) {
      console.error("Get languages error:", error);
      res.status(500).json({ message: "Diller alınırken hata oluştu" });
    }
  });

  // Get all categories
  app.get("/api/categories", async (req: Request, res: Response) => {
    try {
      const allCategories = await db.query.categories.findMany({
        where: eq(categories.isActive, true),
      });

      res.json({ categories: allCategories });
    } catch (error) {
      console.error("Get categories error:", error);
      res.status(500).json({ message: "Kategoriler alınırken hata oluştu" });
    }
  });

  // Get all agencies
  app.get("/api/agencies", async (req: Request, res: Response) => {
    try {
      const allAgencies = await db.query.agencies.findMany({
        where: eq(agencies.isActive, true),
      });

      res.json({ agencies: allAgencies });
    } catch (error) {
      console.error("Get agencies error:", error);
      res.status(500).json({ message: "Ajanslar alınırken hata oluştu" });
    }
  });

  // Get all pricing
  app.get("/api/pricing", async (req: Request, res: Response) => {
    try {
      const allPricing = await db.query.kolPricing.findMany({
        where: eq(kolPricing.isActive, true),
        with: {
          kol: true,
        },
        orderBy: [desc(kolPricing.createdAt)],
      });

      res.json({ pricing: allPricing });
    } catch (error) {
      console.error("Get pricing error:", error);
      res.status(500).json({ message: "Fiyatlar alınırken hata oluştu" });
    }
  });
}
