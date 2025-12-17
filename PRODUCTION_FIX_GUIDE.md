# 🔧 Production Fix Guide - MagnorWeb

Bu rehber, production sunucunuzdaki **nanoid** ve **DATABASE_URL** hatalarını düzeltmek için hazırlanmıştır.

## 🐛 Tespit Edilen Hatalar

1. ❌ **Error: Cannot find package 'nanoid'**
   - Sebep: nanoid paketi package.json'da eksikti
   - Çözüm: ✅ package.json'a nanoid eklendi

2. ❌ **Error: DATABASE_URL environment variable is not set**
   - Sebep: PostgreSQL kurulmamış veya connection string tanımlanmamış
   - Çözüm: ✅ Otomatik kurulum scripti hazırlandı

---

## 🚀 Hızlı Düzeltme (3 Adım)

### Adım 1: Yerel Değişiklikleri GitHub'a Push Et

Yerel bilgisayarınızda (şu anki konumunuzda):

```bash
git add .
git commit -m "Fix: Add nanoid dependency and PostgreSQL configuration"
git push origin main
```

### Adım 2: Sunucuya Bağlan ve Fix Script'i Çalıştır

Sunucunuza SSH ile bağlanın:

```bash
ssh root@SUNUCU_IP_ADRESI
```

Sunucuda şu komutları çalıştırın:

```bash
# Proje dizinine git
cd /var/www/MagnorWeb

# Fix scriptini çalıştır
bash scripts/server-fix-deployment.sh
```

**Script şunları yapacak:**
- ✅ PostgreSQL kurulumunu kontrol eder (yoksa kurar)
- ✅ Database ve user oluşturur (yoksa)
- ✅ Sizden PostgreSQL şifresi sorar
- ✅ Güncel kodu GitHub'dan çeker
- ✅ nanoid dahil tüm paketleri kurar
- ✅ Database schema'sını günceller
- ✅ Production build yapar
- ✅ PM2 ile uygulamayı yeniden başlatır

### Adım 3: Doğrulama

Script tamamlandıktan sonra:

```bash
# PM2 durumunu kontrol et
pm2 status

# Son 50 satır log'u göster
pm2 logs magnorweb --lines 50
```

**Başarılı çıktı:**
```
1|magnorwe | serving on port 5001
```

Tarayıcınızdan test edin:
- `http://SUNUCU_IP:5001` veya
- `https://magnor.agency` (eğer Nginx kuruluysa)

---

## 🔧 Manuel Düzeltme (Detaylı)

Eğer otomatik script çalışmazsa, manuel olarak düzeltme yapabilirsiniz:

### 1️⃣ PostgreSQL Kurulumu ve Ayarları

```bash
# PostgreSQL kur
sudo apt update
sudo apt install -y postgresql postgresql-contrib

# PostgreSQL başlat
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Database oluştur
sudo -u postgres psql << 'EOF'
CREATE DATABASE magnorweb;
CREATE USER magnor_user WITH PASSWORD 'GüçlüŞifreniz123!';
GRANT ALL PRIVILEGES ON DATABASE magnorweb TO magnor_user;
ALTER DATABASE magnorweb OWNER TO magnor_user;
\q
EOF
```

### 2️⃣ Proje Güncelleme

```bash
cd /var/www/MagnorWeb

# Güncel kodu çek
git pull origin main

# Dependencies kur (nanoid dahil)
npm install --production=false

# Database schema güncelle
export DATABASE_URL="postgresql://magnor_user:GüçlüŞifreniz123!@localhost/magnorweb"
npm run db:push
```

### 3️⃣ ecosystem.config.cjs Düzenleme

```bash
# Dosyayı düzenle
nano ecosystem.config.cjs
```

`YOUR_PASSWORD` yerine gerçek şifrenizi yazın:

```javascript
"DATABASE_URL": "postgresql://magnor_user:GüçlüŞifreniz123!@localhost/magnorweb"
```

Kaydet: `CTRL + X`, sonra `Y`, sonra `ENTER`

### 4️⃣ Build ve Restart

```bash
# Build yap
npm run build

# PM2'yi restart et
pm2 delete magnorweb
pm2 start ecosystem.config.cjs --env production
pm2 save

# Logları kontrol et
pm2 logs magnorweb
```

---

## 🔍 Sorun Giderme

### Hata: "Cannot find package 'nanoid'"

**Çözüm:**
```bash
cd /var/www/MagnorWeb
git pull origin main
npm install
npm run build
pm2 restart magnorweb
```

### Hata: "DATABASE_URL environment variable is not set"

**Kontroller:**

1. PostgreSQL çalışıyor mu?
```bash
sudo systemctl status postgresql
```

2. Database ve user var mı?
```bash
sudo -u postgres psql -c "\l" | grep magnorweb
sudo -u postgres psql -c "\du" | grep magnor_user
```

3. ecosystem.config.cjs doğru mu?
```bash
cat ecosystem.config.cjs | grep DATABASE_URL
```

### Hata: "ECONNREFUSED 127.0.0.1:5432"

PostgreSQL başlatın:
```bash
sudo systemctl start postgresql
sudo systemctl enable postgresql
```

### PM2 Loglarında Başka Hatalar

Tüm log dosyalarını kontrol edin:
```bash
# Error logları
tail -f /var/log/pm2/magnorweb-error.log

# Output logları
tail -f /var/log/pm2/magnorweb-out.log

# PM2 logları
pm2 logs magnorweb --lines 100
```

---

## 📝 Önemli Notlar

### PostgreSQL Şifre Güvenliği

- Güçlü bir şifre kullanın (en az 12 karakter, büyük/küçük harf, rakam, özel karakter)
- Şifreyi güvenli bir yerde saklayın (örn: password manager)
- Şifreyi asla GitHub'a push etmeyin

### Database Connection String Formatı

```
postgresql://[USER]:[PASSWORD]@[HOST]/[DATABASE]
```

**Örnek:**
```
postgresql://magnor_user:MyStr0ng!Pass@localhost/magnorweb
```

### Port Yapılandırması

- **Uygulama:** Port 5001
- **PostgreSQL:** Port 5432 (default)
- **Nginx:** Port 80 (HTTP) ve 443 (HTTPS)

---

## ✅ Başarı Kriterleri

Aşağıdakiler çalışıyorsa deployment başarılıdır:

- [x] `pm2 status` komutu "online" gösteriyor
- [x] `pm2 logs magnorweb` hatası yok
- [x] Tarayıcıdan siteye erişilebiliyor
- [x] Login sayfası açılıyor
- [x] Admin giriş yapabiliyor

---

## 🆘 Acil Yardım

Eğer hiçbir şey çalışmazsa:

1. **PM2'yi durdurun:**
```bash
pm2 stop all
```

2. **Manuel çalıştırma ile test edin:**
```bash
cd /var/www/MagnorWeb
export DATABASE_URL="postgresql://magnor_user:ŞİFRE@localhost/magnorweb"
export NODE_ENV=production
export PORT=5001
node dist/index.js
```

3. **Hata mesajlarını göreceksiniz.** Bu mesajları kaydedin.

4. **GitHub Issues'da bildirin veya destek alın.**

---

## 📞 İletişim

- **GitHub:** https://github.com/AlperAcarAI/MagnorWeb
- **Issues:** https://github.com/AlperAcarAI/MagnorWeb/issues

---

**Son Güncelleme:** 17 Aralık 2025
