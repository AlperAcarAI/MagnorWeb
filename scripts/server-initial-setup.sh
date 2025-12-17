#!/bin/bash

# MagnorWeb - İlk Sunucu Kurulum Script
# Bu script sunucuda ilk kez çalıştırılır

set -e

echo "🏗️  MagnorWeb - İlk Sunucu Kurulumu"
echo "===================================="
echo ""

# Renkler
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

success() { echo -e "${GREEN}✅ $1${NC}"; }
error() { echo -e "${RED}❌ $1${NC}"; }
warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
info() { echo -e "${BLUE}ℹ️  $1${NC}"; }

# Değişkenler
PROJECT_DIR="/var/www/magnorweb"
DB_NAME="magnorweb"
DB_USER="magnor_user"
DB_PASSWORD=""

# Veritabanı şifresi sor
echo "🔐 PostgreSQL Kurulumu"
echo ""
read -sp "PostgreSQL şifresi girin (magnor_user için): " DB_PASSWORD
echo ""
echo ""

if [ -z "$DB_PASSWORD" ]; then
    error "Şifre boş olamaz!"
    exit 1
fi

echo "1️⃣  Sistem paketleri güncelleniyor..."
apt-get update -qq
success "Sistem güncellendi"
echo ""

echo "2️⃣  Node.js kurulumu kontrol ediliyor..."
if ! command -v node &> /dev/null; then
    echo "   Node.js kuruluyor..."
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
    apt-get install -y nodejs
    success "Node.js kuruldu"
else
    NODE_VERSION=$(node --version)
    success "Node.js zaten kurulu: $NODE_VERSION"
fi
echo ""

echo "3️⃣  PM2 kurulumu kontrol ediliyor..."
if ! command -v pm2 &> /dev/null; then
    echo "   PM2 kuruluyor..."
    npm install -g pm2
    success "PM2 kuruldu"
else
    success "PM2 zaten kurulu"
fi
echo ""

echo "4️⃣  Git kurulumu kontrol ediliyor..."
if ! command -v git &> /dev/null; then
    echo "   Git kuruluyor..."
    apt-get install -y git
    success "Git kuruldu"
else
    success "Git zaten kurulu"
fi
echo ""

echo "5️⃣  PostgreSQL veritabanı oluşturuluyor..."
sudo -u postgres psql << EOF
-- Veritabanı varsa sil (dikkatli!)
DROP DATABASE IF EXISTS $DB_NAME;
DROP USER IF EXISTS $DB_USER;

-- Yeni veritabanı ve kullanıcı oluştur
CREATE DATABASE $DB_NAME;
CREATE USER $DB_USER WITH ENCRYPTED PASSWORD '$DB_PASSWORD';
ALTER DATABASE $DB_NAME OWNER TO $DB_USER;

-- İzinleri ver
\c $DB_NAME
GRANT ALL ON SCHEMA public TO $DB_USER;
GRANT CREATE ON SCHEMA public TO $DB_USER;
EOF
success "PostgreSQL veritabanı oluşturuldu"
echo ""

echo "6️⃣  Proje klasörü oluşturuluyor..."
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"
success "Proje klasörü: $PROJECT_DIR"
echo ""

echo "7️⃣  GitHub'dan proje klonlanıyor..."
if [ -d ".git" ]; then
    warning "Git repository zaten mevcut, güncelleniyor..."
    git pull origin main
else
    git clone https://github.com/AlperAcarAI/MagnorWeb.git .
fi
success "Proje klonlandı"
echo ""

echo "8️⃣  .env dosyası oluşturuluyor..."
cat > .env << EOF
NODE_ENV=production
PORT=5001
DATABASE_URL=postgresql://$DB_USER:$DB_PASSWORD@localhost:5432/$DB_NAME
EOF
success ".env dosyası oluşturuldu"
echo ""

echo "9️⃣  Dependencies kuruluyor..."
npm install
success "Dependencies kuruldu"
echo ""

echo "🔟 Database dump restore edilecek mi?"
echo "   Dump dosyası yolu: $PROJECT_DIR/magnorweb_dump.sql"
if [ -f "magnorweb_dump.sql" ]; then
    info "Dump dosyası bulundu, restore ediliyor..."
    psql -U $DB_USER -d $DB_NAME -h localhost -f magnorweb_dump.sql
    success "Database restore edildi"
    
    # Admin şifresini güncelle
    echo ""
    info "Admin şifresi güncelleniyor..."
    npx tsx scripts/update-admin-password.ts
else
    warning "Dump dosyası bulunamadı, boş veritabanı ile devam ediliyor..."
    echo ""
    info "Migration çalıştırılıyor..."
    npm run db:push
    success "Tablolar oluşturuldu"
    
    echo ""
    info "Admin kullanıcısı oluşturuluyor..."
    npx tsx scripts/create-admin.ts
    echo ""
    info "Admin şifresi güncelleniyor (Magnor*54)..."
    npx tsx scripts/update-admin-password.ts
fi
echo ""

echo "1️⃣1️⃣  Production build yapılıyor..."
npm run build
success "Build tamamlandı"
echo ""

echo "1️⃣2️⃣  PM2 ile uygulama başlatılıyor..."
pm2 start ecosystem.config.cjs --env production
pm2 save
pm2 startup
success "Uygulama başlatıldı"
echo ""

echo "1️⃣3️⃣  Firewall ayarları..."
if command -v ufw &> /dev/null; then
    ufw allow 5001 || true
    success "Port 5001 açıldı"
fi
echo ""

success "🎉 Kurulum başarıyla tamamlandı!"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📋 Kurulum Bilgileri:"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🗄️  Database:"
echo "   Host: localhost"
echo "   Database: $DB_NAME"
echo "   User: $DB_USER"
echo ""
echo "👤 Admin Credentials:"
echo "   Username: admin"
echo "   Password: Magnor*54"
echo ""
echo "🌐 Uygulama:"
echo "   URL: http://localhost:5001"
echo ""
echo "📊 PM2 Komutları:"
echo "   pm2 status"
echo "   pm2 logs magnorweb"
echo "   pm2 restart magnorweb"
echo ""
echo "🔄 Güncelleme için:"
echo "   cd $PROJECT_DIR"
echo "   bash scripts/server-deploy.sh"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
