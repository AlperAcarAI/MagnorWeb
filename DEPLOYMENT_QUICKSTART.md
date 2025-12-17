# ⚡ Hızlı Deployment Rehberi

## 🎯 Yerel Bilgisayardan (Şimdi)

### 1. Database Backup Al
```bash
bash scripts/export-database.sh
```

### 2. Dump Dosyasını Sunucuya Gönder
```bash
scp magnorweb_dump_*.sql root@SUNUCU_IP:/tmp/magnorweb_dump.sql
```

### 3. Değişiklikleri GitHub'a Push Et
```bash
git add .
git commit -m "Production deployment"
git push origin main
```

---

## 🖥️ Sunucuda (İlk Kez Kurulum)

### 1. Sunucuya Bağlan
```bash
ssh root@SUNUCU_IP
```

### 2. Dump Dosyasını Proje Klasörüne Taşı
```bash
# Önce kurulum scriptini çalıştır
cd /tmp
curl -O https://raw.githubusercontent.com/AlperAcarAI/MagnorWeb/main/scripts/server-initial-setup.sh
chmod +x server-initial-setup.sh

# Dump'ı geçici klasöre kopyalamayı unutma
# (Eğer önceden gönderdiyseniz zaten /tmp/magnorweb_dump.sql de olmalı)

# Kurulumu başlat
sudo bash server-initial-setup.sh
```

Script sizden PostgreSQL şifresi soracak. Güçlü bir şifre girin ve kaydedin!

### 3. Kurulum Sonrası Kontrol
```bash
# PM2 durumu
pm2 status

# Loglar
pm2 logs magnorweb --lines 50

# Veritabanı kontrolü
psql -U magnor_user -d magnorweb -h localhost -c "SELECT COUNT(*) FROM users;"
```

### 4. Tarayıcıdan Test Et
- URL: `http://SUNUCU_IP:5001`
- Kullanıcı: `admin`
- Şifre: `Magnor*54`

---

## 🔄 Sonraki Güncellemeler İçin

### Sunucuda Hızlı Güncelleme
```bash
ssh root@SUNUCU_IP
cd /var/www/magnorweb
bash scripts/server-deploy.sh
```

Bu kadar! 🎉

---

## 📌 Önemli Notlar

- **PostgreSQL Şifresi:** Kurulum sırasında belirlediğiniz şifreyi güvenli bir yerde saklayın
- **Admin Şifresi:** Varsayılan `Magnor*54` - İlk girişten sonra değiştirin
- **.env Dosyası:** Sunucuda otomatik oluşturulur
- **Firewall:** Port 5001 otomatik açılır

---

## 🆘 Sorun mu yaşıyorsunuz?

Detaylı rehber için: [SERVER_DEPLOYMENT.md](./SERVER_DEPLOYMENT.md)

### Hızlı Çözümler

**Uygulama çalışmıyor:**
```bash
pm2 logs magnorweb
```

**Database bağlantı hatası:**
```bash
psql -U magnor_user -d magnorweb -h localhost
```

**Port erişim sorunu:**
```bash
sudo ufw allow 5001
```

---

## 📂 Script Dosyaları

| Script | Kullanım | Ne Zaman |
|--------|----------|----------|
| `export-database.sh` | Yerel DB dump alma | Deployment öncesi |
| `server-initial-setup.sh` | İlk kurulum | Sunucuda ilk kez |
| `server-deploy.sh` | Güncelleme | Her deployment |
| `update-admin-password.ts` | Admin şifre değiştir | İhtiyaç halinde |

---

**Başarılar! 🚀**
