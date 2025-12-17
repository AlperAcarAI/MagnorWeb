# 🌟 MagnorWeb - KOL Management Platform

MagnorWeb, influencer (KOL - Key Opinion Leader) ve ajans yönetimi için geliştirilmiş modern bir web platformudur.

## 🚀 Özellikler

- 👥 **KOL Yönetimi**: Influencer'ları ve sosyal medya hesaplarını yönetin
- 💰 **Fiyatlandırma**: Kampanya fiyatları ve paket yönetimi
- 🏢 **Ajans Yönetimi**: Ajanslar ve komisyon oranları
- 📊 **Raporlama**: Detaylı istatistikler ve analizler
- 🔒 **Güvenli Giriş**: Kullanıcı yönetimi ve rol bazlı erişim
- 🌐 **Modern UI**: React + TailwindCSS ile responsive tasarım

## 📦 Teknoloji Stack'i

### Frontend
- **React 18** - UI kütüphanesi
- **TypeScript** - Tip güvenliği
- **TailwindCSS** - Styling
- **Wouter** - Routing
- **TanStack Query** - Veri yönetimi
- **Radix UI** - Erişilebilir UI komponentleri

### Backend
- **Node.js** - Runtime
- **Express** - Web framework
- **TypeScript** - Tip güvenliği
- **PostgreSQL** - Veritabanı
- **Drizzle ORM** - ORM
- **bcryptjs** - Şifreleme

## 🛠️ Kurulum

### Gereksinimler
- Node.js 18.x veya üzeri
- PostgreSQL 12 veya üzeri
- npm veya yarn

### Yerel Geliştirme Ortamı

1. **Repoyu klonlayın:**
```bash
git clone https://github.com/AlperAcarAI/MagnorWeb.git
cd MagnorWeb
```

2. **Dependencies kurun:**
```bash
npm install
```

3. **.env dosyası oluşturun:**
```bash
cp .env.production.example .env
```

.env dosyasını düzenleyin:
```env
NODE_ENV=development
PORT=5001
DATABASE_URL=postgresql://postgres:password@localhost:5432/magnorweb
```

4. **Veritabanını oluşturun:**
```bash
# PostgreSQL'e bağlanın
psql -U postgres

# Veritabanı oluşturun
CREATE DATABASE magnorweb;
\q

# Migration çalıştırın
npm run db:push
```

5. **Admin kullanıcısı oluşturun:**
```bash
npx tsx scripts/create-admin.ts

# Admin şifresini güncelleyin (isteğe bağlı)
npx tsx scripts/update-admin-password.ts
```

6. **Development server'ı başlatın:**
```bash
npm run dev
```

Uygulama `http://localhost:5001` adresinde çalışacak.

**Varsayılan giriş bilgileri:**
- Kullanıcı adı: `admin`
- Şifre: `Magnor*54`

## 🚀 Production Deployment

### Hızlı Başlangıç
Hızlı deployment için: **[DEPLOYMENT_QUICKSTART.md](./DEPLOYMENT_QUICKSTART.md)**

### Detaylı Rehber
Tam deployment rehberi için: **[SERVER_DEPLOYMENT.md](./SERVER_DEPLOYMENT.md)**

### Deployment Scriptleri

Projeyle birlikte gelen deployment scriptleri:

```bash
# Yerel veritabanından dump al
bash scripts/export-database.sh

# Sunucuda ilk kurulum (sadece bir kez)
sudo bash scripts/server-initial-setup.sh

# Sunucuda güncelleme (her deployment)
bash scripts/server-deploy.sh
```

## 📁 Proje Yapısı

```
MagnorWeb/
├── client/                 # Frontend (React)
│   ├── src/
│   │   ├── pages/         # Sayfa komponentleri
│   │   ├── components/    # UI komponentleri
│   │   ├── hooks/         # Custom hooks
│   │   └── lib/           # Utility fonksiyonlar
│   └── public/            # Statik dosyalar
├── server/                # Backend (Express)
│   ├── auth.ts           # Authentication logic
│   ├── routes.ts         # API routes
│   └── index.ts          # Server entry point
├── db/                    # Database
│   └── index.ts          # DB connection
├── shared/               # Paylaşılan kodlar
│   └── schema.ts         # Drizzle schema
├── scripts/              # Utility scripts
│   ├── export-database.sh
│   ├── server-initial-setup.sh
│   ├── server-deploy.sh
│   └── update-admin-password.ts
└── migrations/           # Database migrations
```

## 🔧 Faydalı Komutlar

```bash
# Development
npm run dev              # Dev server başlat
npm run check            # TypeScript kontrolü

# Database
npm run db:push          # Migration çalıştır

# Production
npm run build            # Production build
npm start                # Production server başlat
```

## 📊 Database Schema

Veritabanı yapısı hakkında detaylı bilgi için:
- [DATABASE_DESIGN.md](./DATABASE_DESIGN.md)
- [DATABASE_CONNECTION.md](./DATABASE_CONNECTION.md)

## 🔐 Güvenlik

- Şifreler bcrypt ile hash'lenir
- Session-based authentication
- CORS koruması
- SQL injection koruması (Drizzle ORM)
- XSS koruması

## 🤝 Katkıda Bulunma

1. Fork edin
2. Feature branch oluşturun (`git checkout -b feature/amazing-feature`)
3. Değişikliklerinizi commit edin (`git commit -m 'feat: Add amazing feature'`)
4. Branch'inizi push edin (`git push origin feature/amazing-feature`)
5. Pull Request açın

## 📝 Lisans

Bu proje MIT lisansı altında lisanslanmıştır.

## 📧 İletişim

- GitHub: [@AlperAcarAI](https://github.com/AlperAcarAI)
- Repository: [MagnorWeb](https://github.com/AlperAcarAI/MagnorWeb)

## 🙏 Teşekkürler

Bu proje şu harika teknolojiler kullanılarak geliştirilmiştir:
- [React](https://react.dev/)
- [TypeScript](https://www.typescriptlang.org/)
- [TailwindCSS](https://tailwindcss.com/)
- [Drizzle ORM](https://orm.drizzle.team/)
- [PostgreSQL](https://www.postgresql.org/)
- [Express](https://expressjs.com/)

---

**Made with ❤️ by Alper Acar**
