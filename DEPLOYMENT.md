# MagnorWeb Deployment Talimatları

## Digital Ocean Ubuntu Sunucusunda Kurulum

### 1. Sunucuya Bağlanma
```bash
ssh root@your-server-ip
```

### 2. Gerekli Paketleri Kurma
```bash
# Node.js ve npm kurulumu (Node.js 18.x veya üzeri)
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
apt-get install -y nodejs

# PM2 kurulumu (process manager)
npm install -g pm2

# Git kurulumu
apt-get install -y git
```

### 3. Proje Klasörünü Oluşturma
```bash
mkdir -p /var/www/magnorweb
cd /var/www/magnorweb
```

### 4. GitHub'dan Projeyi Klonlama
```bash
# İlk kez klonlama
git clone https://github.com/AlperAcarAI/MagnorWeb.git .

# Veya mevcut projeyi güncelleme
git pull origin main
```

### 5. Bağımlılıkları Kurma
```bash
npm install
```

### 6. Production Build
```bash
npm run build
```

**ÖNEMLİ:** `vite.config.ts` dosyasında `publicDir` eklendi. Bu sayede `client/public/logos` klasöründeki tüm logolar otomatik olarak `dist/public/logos` klasörüne kopyalanacak.

### 7. Uygulamayı PM2 ile Başlatma
```bash
# İlk kez başlatma
pm2 start ecosystem.config.cjs --env production

# Veya restart
pm2 restart magnorweb

# PM2'yi sistem başlangıcında otomatik başlatma
pm2 startup
pm2 save
```

### 8. Nginx Konfigürasyonu (Opsiyonel - Port 80/443 için)
```bash
# Nginx kurulumu
apt-get install -y nginx

# Nginx konfigürasyonu
nano /etc/nginx/sites-available/magnorweb
```

Nginx config içeriği:
```nginx
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://localhost:5000;
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

```bash
# Siteyi aktif etme
ln -s /etc/nginx/sites-available/magnorweb /etc/nginx/sites-enabled/
nginx -t
systemctl restart nginx
```

## Güncelleme İşlemi (Update/Redeploy)

Sunucuda yapılacak işlemler:

```bash
cd /var/www/magnorweb
git pull origin main
npm install
npm run build
pm2 restart magnorweb
```

## Logları Kontrol Etme

```bash
# PM2 logları
pm2 logs magnorweb

# Sadece son loglar
pm2 logs magnorweb --lines 100

# PM2 durumu
pm2 status
```

## Sorun Giderme

### Logolar Görünmüyorsa:
1. Build işleminin başarıyla tamamlandığını kontrol edin:
   ```bash
   ls -la /var/www/magnorweb/dist/public/logos/
   ```

2. Dosya izinlerini kontrol edin:
   ```bash
   chmod -R 755 /var/www/magnorweb/dist
   ```

3. PM2'yi yeniden başlatın:
   ```bash
   pm2 restart magnorweb
   ```

### Port 5000'e Erişilemiyor:
```bash
# Firewall kontrol
ufw status
ufw allow 5000
```

## Ortam Değişkenleri (.env)

Sunucuda `.env` dosyası oluşturun:
```bash
nano /var/www/magnorweb/.env
```

Gerekli environment variables:
```env
NODE_ENV=production
PORT=5000
DATABASE_URL=your_database_url
```

## deploy.sh Hakkında

`deploy.sh` scripti artık gerekli değil. GitHub workflow ile veya manuel olarak sunucuda direkt `git pull` ve `npm run build` yapabilirsiniz.
