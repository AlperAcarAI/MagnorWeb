import { Express, Request, Response } from "express";
import { db } from "../db";
import { users } from "@shared/schema";
import { eq, or } from "drizzle-orm";
import bcrypt from "bcryptjs";

// Extend Express Request to include user session
declare global {
  namespace Express {
    interface Request {
      user?: {
        id: string;
        username: string;
        email: string | null;
        role: string;
      };
    }
  }
}

// Session store (in-memory for development - use Redis in production)
const sessions = new Map<string, { userId: string; expiresAt: Date }>();

// Generate session token
function generateSessionToken(): string {
  return Math.random().toString(36).substring(2) + Date.now().toString(36);
}

// Middleware to check authentication
export function requireAuth(req: Request, res: Response, next: Function) {
  const sessionToken = req.headers.authorization?.replace("Bearer ", "") || 
                      req.cookies?.sessionToken;

  if (!sessionToken) {
    return res.status(401).json({ message: "Giriş yapmanız gerekiyor" });
  }

  const session = sessions.get(sessionToken);
  
  if (!session || session.expiresAt < new Date()) {
    sessions.delete(sessionToken);
    return res.status(401).json({ message: "Oturum süresi dolmuş" });
  }

  // Session'ı uzat
  session.expiresAt = new Date(Date.now() + 24 * 60 * 60 * 1000); // 24 hours
  
  // User bilgilerini request'e ekle (next middleware için)
  // Bu bilgiyi database'den almak için ayrı bir sorgu yapabiliriz
  next();
}

export function setupAuth(app: Express) {
  // Login endpoint
  app.post("/api/auth/login", async (req: Request, res: Response) => {
    try {
      const { username, password } = req.body;

      if (!username || !password) {
        return res.status(400).json({ 
          message: "Kullanıcı adı ve şifre gereklidir" 
        });
      }

      // Kullanıcıyı username veya email ile bul
      const [user] = await db
        .select()
        .from(users)
        .where(
          or(
            eq(users.username, username),
            eq(users.email, username)
          )
        )
        .limit(1);

      if (!user) {
        return res.status(401).json({ 
          message: "Kullanıcı adı veya şifre hatalı" 
        });
      }

      // Kullanıcı aktif mi kontrol et
      if (!user.isActive) {
        return res.status(403).json({ 
          message: "Hesabınız devre dışı bırakılmış" 
        });
      }

      // Şifre kontrolü
      const isPasswordValid = await bcrypt.compare(password, user.password);

      if (!isPasswordValid) {
        return res.status(401).json({ 
          message: "Kullanıcı adı veya şifre hatalı" 
        });
      }

      // Session oluştur
      const sessionToken = generateSessionToken();
      const expiresAt = new Date(Date.now() + 24 * 60 * 60 * 1000); // 24 hours

      sessions.set(sessionToken, {
        userId: user.id,
        expiresAt,
      });

      // Last login güncelle
      await db
        .update(users)
        .set({ lastLogin: new Date() })
        .where(eq(users.id, user.id));

      // Cookie set et
      res.cookie("sessionToken", sessionToken, {
        httpOnly: true,
        secure: process.env.NODE_ENV === "production",
        sameSite: "lax",
        maxAge: 24 * 60 * 60 * 1000, // 24 hours
      });

      // Başarılı response
      res.json({
        message: "Giriş başarılı",
        user: {
          id: user.id,
          username: user.username,
          email: user.email,
          role: user.role,
        },
        sessionToken, // Frontend için (opsiyonel)
      });

    } catch (error) {
      console.error("Login error:", error);
      res.status(500).json({ message: "Sunucu hatası" });
    }
  });

  // Logout endpoint
  app.post("/api/auth/logout", (req: Request, res: Response) => {
    const sessionToken = req.cookies?.sessionToken;

    if (sessionToken) {
      sessions.delete(sessionToken);
      res.clearCookie("sessionToken");
    }

    res.json({ message: "Çıkış başarılı" });
  });

  // Get current user endpoint
  app.get("/api/auth/me", async (req: Request, res: Response) => {
    try {
      const sessionToken = req.cookies?.sessionToken;

      if (!sessionToken) {
        return res.status(401).json({ message: "Giriş yapılmamış" });
      }

      const session = sessions.get(sessionToken);

      if (!session || session.expiresAt < new Date()) {
        sessions.delete(sessionToken);
        res.clearCookie("sessionToken");
        return res.status(401).json({ message: "Oturum süresi dolmuş" });
      }

      // User bilgilerini getir
      const [user] = await db
        .select({
          id: users.id,
          username: users.username,
          email: users.email,
          role: users.role,
          isActive: users.isActive,
          lastLogin: users.lastLogin,
        })
        .from(users)
        .where(eq(users.id, session.userId))
        .limit(1);

      if (!user) {
        sessions.delete(sessionToken);
        res.clearCookie("sessionToken");
        return res.status(401).json({ message: "Kullanıcı bulunamadı" });
      }

      if (!user.isActive) {
        sessions.delete(sessionToken);
        res.clearCookie("sessionToken");
        return res.status(403).json({ message: "Hesap devre dışı" });
      }

      // Session'ı uzat
      session.expiresAt = new Date(Date.now() + 24 * 60 * 60 * 1000);

      res.json({ user });

    } catch (error) {
      console.error("Get user error:", error);
      res.status(500).json({ message: "Sunucu hatası" });
    }
  });

  // Check session validity (for frontend)
  app.get("/api/auth/check", (req: Request, res: Response) => {
    const sessionToken = req.cookies?.sessionToken;

    if (!sessionToken) {
      return res.json({ authenticated: false });
    }

    const session = sessions.get(sessionToken);

    if (!session || session.expiresAt < new Date()) {
      sessions.delete(sessionToken);
      res.clearCookie("sessionToken");
      return res.json({ authenticated: false });
    }

    res.json({ authenticated: true });
  });
}
