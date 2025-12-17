# 🚀 MagnorWeb Sunucu Deployment Rehberi

## 📋 İçindekiler
1. [Gereksinimler](#gereksinimler)
2. [İlk Kurulum (Boş Sunucu)](#ilk-kurulum-boş-sunucu)
3. [Veri ile Kurulum (Mevcut Database)](#veri-ile-kurulum-mevcut-database)
4. [Güncelleme (Update)](#güncelleme-update)
5. [Nginx Kurulumu (Opsiyonel)](#nginx-kurulumu)
6. [SSL Sertifikası (Opsiyonel)](#ssl-sertifikası)
7. [Sorun Giderme](#sorun-giderme)

---

## Gereksinimler

### Sunucu Gereksinimleri
- Ubuntu 20.04 LTS veya üzeri
- En az 2GB RAM
- En az 20GB disk alanı
- Root veya sudo erişimi
- PostgreSQL 12 veya üzeri

### Yerel Bilgisayar Gereksinimleri
- Git
- PostgreSQL (eğer veri aktarımı yapılacaksa)
- SSH erişimi

---

## İlk Kurulum (Boş Sunucu)

### Adım 1: Sunucuya Bağlanma
```bash
ssh root@SUNUCU_IP
```

### Adım 2: PostgreSQL Kurulumu (Eğer kurulu değilse)
```bash
# PostgreSQL kurulumu
sudo apt update
sudo apt install postgresql postgresql-contrib -y

# PostgreSQL servisini başlat
sudo systemctl start postgresql
sudo systemctl enable postgresql
```

### Adım 3: Kurulum Scriptini İndirme
```bash
# Geçici dizinde script indir
cd /tmp
curl -O https://raw.githubusercontent.com/AlperAcarAI/MagnorWeb/main/scripts/server-initial-setup.sh
chmod +x server-initial-setup.sh
```

### Adım 4: İlk Kurulumu Çalıştırma
```bash
# Root olarak çalıştır
sudo bash server-initial-setup.sh
```

Script size PostgreSQL şifresi soracak. Güçlü bir şifre belirleyin ve kaydedin!

**Script şunları yapacak:**
- ✅ Node.js ve PM2 kurulumu
- ✅ PostgreSQL veritabanı oluşturma
- ✅ GitHub'dan projeyi klonlama
- ✅ .env dosyası oluşturma
- ✅ Dependencies kurulumu
- ✅ Admin kullanıcısı oluşturma (şifre: Magnor*54)
- ✅ Production build
- ✅ PM2 ile uygulamayı başlatma

### Adım 5: Kurulum Tamamlandı! 🎉
```bash
# PM2 durumunu kontrol et
pm2 status

# Logları kontrol et
pm2 logs magnorweb

# Uygulamaya tarayıcıdan eriş:
# http://SUNUCU_IP:5001
```

**Giriş Bilgileri:**
- Kullanıcı adı: `admin`
- Şifre: `Magnor*54`

---

## Veri ile Kurulum (Mevcut Database)

### Adım 1: Yerel Bilgisayardan Database Dump Alma

```bash
# Export script ile dump al
bash scripts/export-database.sh

# Veya manuel:
pg_dump -U postgres -d magnorweb > magnorweb_dump.sql
```

### Adım 2: Dump Dosyasını Sunucuya Gönderme
```bash
# SCP ile gönder
scp magnorweb_dump_*.sql root@SUNUCU_IP:/tmp/magnorweb_dump.sql
```

### Adım 3: Sunucuda İlk Kurulum
```bash
# Sunucuya bağlan
ssh root@SUNUCU_IP

# Kurulum scriptini çalıştır
cd /tmp
curl -O https://raw.githubusercontent.com/AlperAcarAI/MagnorWeb/main/scripts/server-initial-setup.sh
chmod +x server-initial-setup.sh
sudo bash server-initial-setup.sh

# Script bittiğinde, dump'ı proje klasörüne kopyala
cp /tmp/magnorweb_dump.sql /var/www/magnorweb/
```

### Adım 4: Dump'ı Manuel Restore Etme (Script otomatik yapmadıysa)
```bash
cd /var/www/magnorweb

# Önce şifreyi environment variable olarak tanımla
export PGPASSWORD='postgresql_şifreniz'

# Database restore et
psql -U magnor_user -d magnorweb -h localhost -f magnorweb_dump.sql

# Admin şifresini güncelle
npx tsx scripts/update-admin-password.ts

# PM2'yi restart et
pm2 restart magnorweb
```

---

## Güncelleme (Update)

Kod güncellemeleri için basit güncelleme işlemi:

### Otomatik Güncelleme (Önerilen)
```bash
# Sunucuya bağlan
ssh root@SUNUCU_IP

# Deploy scriptini çalıştır
cd /var/www/magnorweb
bash scripts/server-deploy.sh
```

### Manuel Güncelleme
```bash
cd /var/www/magnorweb

# Git pull
git pull origin main

# Dependencies güncelle
npm install

# Build yap
npm run build

# PM2 restart
pm2 restart magnorweb

# Logları kontrol et
pm2 logs magnorweb
```

---

## Nginx Kurulumu

Port 80 ve 443 için Nginx reverse proxy kurulumu:

### Adım 1: Nginx Kurulumu
```bash
sudo apt install nginx -y
```

### Adım 2: Nginx Konfigürasyonu
```bash
sudo nano /etc/nginx/sites-available/magnorweb
```

**Konfigürasyon içeriği:**
```nginx
server {
    listen 80;
    server_name your-domain.com;  # Domain adınız veya IP

    location / {
        proxy_pass http://localhost:5001;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

### Adım 3: Nginx'i Aktif Et
```bash
# Siteyi aktif et
sudo ln -s /etc/nginx/sites-available/magnorweb /etc/nginx/sites-enabled/

# Nginx konfigürasyonunu test et
sudo nginx -t

# Nginx'i restart et
sudo systemctl restart nginx

# Firewall ayarları
sudo ufw allow 'Nginx Full'
```

Artık `http://your-domain.com` veya `http://SUNUCU_IP` ile erişebilirsiniz!

---

## SSL Sertifikası

Let's Encrypt ile ücretsiz SSL sertifikası:

### Adım 1: Certbot Kurulumu
```bash
sudo apt install certbot python3-certbot-nginx -y
```

### Adım 2: SSL Sertifikası Alma
```bash
sudo certbot --nginx -d your-domain.com
```

Certbot otomatik olarak Nginx konfigürasyonunu güncelleyecek ve HTTPS'i aktif edecek.

### Adım 3: Otomatik Yenileme
```bash
# Test yenileme
sudo certbot renew --dry-run

# Otomatik yenileme zaten aktif (cron job)
```

Artık `https://your-domain.com` ile erişebilirsiniz! 🔒

---

## Sorun Giderme

### Uygulama başlamıyor
```bash
# Logları kontrol et
pm2 logs magnorweb --lines 100

# PM2 durumu
pm2 status

# .env dosyasını kontrol et
cat /var/www/magnorweb/.env

# Database bağlantısını test et
psql -U magnor_user -d magnorweb -h localhost -c "SELECT 1;"
```

### Database bağlantı hatası
```bash
# PostgreSQL çalışıyor mu?
sudo systemctl status postgresql

# Database ve user var mı?
sudo -u postgres psql -c "\l" | grep magnorweb
sudo -u postgres psql -c "\du" | grep magnor_user

# Bağlantı test et
psql -U magnor_user -d magnorweb -h localhost
```

### Port 5001'e erişilemiyor
```bash
# Firewall kontrolü
sudo ufw status

# Port'u aç
sudo ufw allow 5001

# Uygulama dinliyor mu?
netstat -tlnp | grep 5001
```

### Build hataları
```bash
# Node modules'ü temizle ve yeniden kur
cd /var/www/magnorweb
rm -rf node_modules
npm install
npm run build
```

### Migration hataları
```bash
# Drizzle kit ile migration çalıştır
cd /var/www/magnorweb
npm run db:push

# Veya manuel SQL'den restore
psql -U magnor_user -d magnorweb -h localhost -f migrations/0000_violet_justice.sql
```

---

## Önemli Dosyalar ve Konumlar

| Dosya/Klasör | Konum |
|--------------|-------|
| Proje dizini | `/var/www/magnorweb` |
| .env dosyası | `/var/www/magnorweb/.env` |
| PM2 logları | `/var/log/pm2/magnorweb-*.log` |
| Nginx config | `/etc/nginx/sites-available/magnorweb` |
| PostgreSQL data | `/var/lib/postgresql/` |

---

## Yardımcı Komutlar

```bash
# PM2 komutları
pm2 status                    # Tüm uygulamaları listele
pm2 logs magnorweb            # Logları göster
pm2 restart magnorweb         # Yeniden başlat
pm2 stop magnorweb            # Durdur
pm2 start magnorweb           # Başlat
pm2 delete magnorweb          # Sil

# Database komutları
psql -U magnor_user -d magnorweb -h localhost     # DB'ye bağlan
\dt                                                 # Tabloları listele
\du                                                 # Kullanıcıları listele
SELECT COUNT(*) FROM users;                        # User sayısı
SELECT COUNT(*) FROM kols;                         # KOL sayısı

# Sistem komutları
df -h                          # Disk kullanımı
free -h                        # Bellek kullanımı
top                           # CPU kullanımı
```

---

## Yedekleme

### Manuel Database Backup
```bash
# Backup al
pg_dump -U magnor_user -d magnorweb -h localhost > backup_$(date +%Y%m%d).sql

# Backup'ı güvenli yere kopyala
scp backup_*.sql user@backup-server:/backups/
```

### Otomatik Günlük Backup (Cron)
```bash
# Cron job ekle
crontab -e

# Her gece saat 2'de backup al
0 2 * * * pg_dump -U magnor_user -d magnorweb > /var/backups/magnorweb_$(date +\%Y\%m\%d).sql
```

---

## İletişim ve Destek

Sorun yaşarsanız:
1. Önce logları kontrol edin: `pm2 logs magnorweb`
2. Database bağlantısını test edin
3. GitHub Issues'a bildirin

**Repository:** https://github.com/AlperAcarAI/MagnorWeb
