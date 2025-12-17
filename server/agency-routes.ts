import { Express, Request, Response } from "express";
import { db } from "../db";
import { agencies } from "../db";
import { eq, asc, desc } from "drizzle-orm";

export function registerAgencyRoutes(app: Express) {
  // Get all agencies
  app.get("/api/agencies-list", async (req: Request, res: Response) => {
    try {
      const allAgencies = await db.query.agencies.findMany({
        where: eq(agencies.isActive, true),
        orderBy: [asc(agencies.name)],
      });

      res.json({ agencies: allAgencies });
    } catch (error: any) {
      console.error("Error fetching agencies:", error);
      res.status(500).json({ message: "Ajanslar alınırken hata oluştu" });
    }
  });

  // Get single agency
  app.get("/api/agencies-list/:id", async (req: Request, res: Response) => {
    try {
      const { id } = req.params;
      
      const agency = await db.query.agencies.findFirst({
        where: eq(agencies.id, id),
      });

      if (!agency) {
        return res.status(404).json({ message: "Ajans bulunamadı" });
      }

      res.json({ agency });
    } catch (error: any) {
      console.error("Error fetching agency:", error);
      res.status(500).json({ message: "Ajans alınırken hata oluştu" });
    }
  });

  // Create agency
  app.post("/api/agencies-list", async (req: Request, res: Response) => {
    try {
      const {
        name,
        contactName,
        contactEmail,
        contactPhone,
        commissionRate,
        notes,
      } = req.body;

      if (!name) {
        return res.status(400).json({ message: "Ajans adı gereklidir" });
      }

      const [newAgency] = await db
        .insert(agencies)
        .values({
          name,
          contactName: contactName || null,
          contactEmail: contactEmail || null,
          contactPhone: contactPhone || null,
          commissionRate: commissionRate || null,
          notes: notes || null,
        })
        .returning();

      res.status(201).json({ 
        message: "Ajans başarıyla oluşturuldu",
        agency: newAgency 
      });
    } catch (error: any) {
      console.error("Error creating agency:", error);
      res.status(500).json({ message: "Ajans oluşturulurken hata oluştu" });
    }
  });

  // Update agency
  app.put("/api/agencies-list/:id", async (req: Request, res: Response) => {
    try {
      const { id } = req.params;
      const {
        name,
        contactName,
        contactEmail,
        contactPhone,
        commissionRate,
        notes,
      } = req.body;

      if (!name) {
        return res.status(400).json({ message: "Ajans adı gereklidir" });
      }

      const [updatedAgency] = await db
        .update(agencies)
        .set({
          name,
          contactName: contactName || null,
          contactEmail: contactEmail || null,
          contactPhone: contactPhone || null,
          commissionRate: commissionRate || null,
          notes: notes || null,
          updatedAt: new Date(),
        })
        .where(eq(agencies.id, id))
        .returning();

      if (!updatedAgency) {
        return res.status(404).json({ message: "Ajans bulunamadı" });
      }

      res.json({ 
        message: "Ajans başarıyla güncellendi",
        agency: updatedAgency 
      });
    } catch (error: any) {
      console.error("Error updating agency:", error);
      res.status(500).json({ message: "Ajans güncellenirken hata oluştu" });
    }
  });

  // Delete agency (soft delete)
  app.delete("/api/agencies-list/:id", async (req: Request, res: Response) => {
    try {
      const { id } = req.params;

      const [deletedAgency] = await db
        .update(agencies)
        .set({
          isActive: false,
          updatedAt: new Date(),
        })
        .where(eq(agencies.id, id))
        .returning();

      if (!deletedAgency) {
        return res.status(404).json({ message: "Ajans bulunamadı" });
      }

      res.json({ message: "Ajans başarıyla silindi" });
    } catch (error: any) {
      console.error("Error deleting agency:", error);
      res.status(500).json({ message: "Ajans silinirken hata oluştu" });
    }
  });
}
