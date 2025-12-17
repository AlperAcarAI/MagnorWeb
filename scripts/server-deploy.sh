#!/bin/bash

# MagnorWeb - Sunucu Deployment Script
# Bu script sunucuda çalıştırılır

set -e

echo "🚀 MagnorWeb - Server Deployment"
echo "=================================="
echo ""

# Renkler
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Proje dizini
PROJECT_DIR="/var/www/magnorweb"
DB_NAME="magnorweb"
DB_USER="magnor_user"

# Fonksiyon: Başarılı mesaj
success() {
    echo -e "${GREEN}✅ $1${NC}"
}

# Fonksiyon: Hata mesajı
error() {
    echo -e "${RED}❌ $1${NC}"
}

# Fonksiyon: Uyarı mesajı
warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

echo "1️⃣  Proje dizinine gidiliyor..."
cd "$PROJECT_DIR" || { error "Proje dizini bulunamadı!"; exit 1; }
success "Proje dizini: $PROJECT_DIR"
echo ""

echo "2️⃣  Git güncellemesi yapılıyor..."
git fetch origin
git pull origin main
success "Git güncellemesi tamamlandı"
echo ""

echo "3️⃣  Dependencies kuruluyor..."
npm install --production=false
success "Dependencies kuruldu"
echo ""

echo "4️⃣  .env dosyası kontrol ediliyor..."
if [ ! -f .env ]; then
    error ".env dosyası bulunamadı!"
    echo "   Lütfen .env dosyasını oluşturun:"
    echo "   nano .env"
    exit 1
fi
success ".env dosyası mevcut"
echo ""

echo "5️⃣  Production build yapılıyor..."
npm run build
success "Build tamamlandı"
echo ""

echo "6️⃣  PM2 ile uygulama başlatılıyor/yeniden başlatılıyor..."
if pm2 list | grep -q "magnorweb"; then
    pm2 restart magnorweb
    success "Uygulama yeniden başlatıldı"
else
    pm2 start ecosystem.config.cjs --env production
    pm2 save
    success "Uygulama ilk kez başlatıldı"
fi
echo ""

echo "7️⃣  PM2 durumu kontrol ediliyor..."
pm2 list
echo ""

success "🎉 Deployment başarıyla tamamlandı!"
echo ""
echo "📊 Logları görmek için:"
echo "   pm2 logs magnorweb"
echo ""
echo "🌐 Uygulamaya erişim:"
echo "   http://localhost:5001"
echo ""
