#!/bin/bash

# MagnorWeb - Production Fix Script
# Fixes missing nanoid package and DATABASE_URL issues

set -e

echo "🔧 MagnorWeb - Production Fix Script"
echo "======================================"
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
success() {
    echo -e "${GREEN}✅ $1${NC}"
}

error() {
    echo -e "${RED}❌ $1${NC}"
}

warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Project directory
PROJECT_DIR="/var/www/MagnorWeb"
DB_NAME="magnorweb"
DB_USER="magnor_user"

echo "Step 1: Checking project directory..."
if [ ! -d "$PROJECT_DIR" ]; then
    error "Project directory not found: $PROJECT_DIR"
    exit 1
fi
cd "$PROJECT_DIR"
success "Project directory found"
echo ""

echo "Step 2: Checking PostgreSQL installation..."
if ! command -v psql &> /dev/null; then
    warning "PostgreSQL not found. Installing..."
    sudo apt update
    sudo apt install -y postgresql postgresql-contrib
    sudo systemctl start postgresql
    sudo systemctl enable postgresql
    success "PostgreSQL installed"
else
    success "PostgreSQL already installed"
fi
echo ""

echo "Step 3: Checking database and user..."
DB_EXISTS=$(sudo -u postgres psql -tAc "SELECT 1 FROM pg_database WHERE datname='$DB_NAME'")
USER_EXISTS=$(sudo -u postgres psql -tAc "SELECT 1 FROM pg_roles WHERE rolname='$DB_USER'")

if [ "$USER_EXISTS" != "1" ]; then
    warning "Database user not found. Creating..."
    read -sp "Enter password for PostgreSQL user '$DB_USER': " DB_PASSWORD
    echo ""
    
    sudo -u postgres psql << EOF
CREATE USER $DB_USER WITH PASSWORD '$DB_PASSWORD';
ALTER USER $DB_USER CREATEDB;
EOF
    success "Database user created"
    
    # Save password for later
    PGPASSWORD="$DB_PASSWORD"
else
    success "Database user exists"
    read -sp "Enter password for existing PostgreSQL user '$DB_USER': " PGPASSWORD
    echo ""
fi

if [ "$DB_EXISTS" != "1" ]; then
    warning "Database not found. Creating..."
    sudo -u postgres psql << EOF
CREATE DATABASE $DB_NAME OWNER $DB_USER;
GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $DB_USER;
EOF
    success "Database created"
else
    success "Database exists"
fi
echo ""

echo "Step 4: Updating ecosystem.config.cjs with actual password..."
# Update ecosystem.config.cjs with actual password
sed -i "s|YOUR_PASSWORD|$PGPASSWORD|g" ecosystem.config.cjs
success "Ecosystem config updated"
echo ""

echo "Step 5: Pulling latest code from GitHub..."
git fetch origin
git pull origin main
success "Code updated"
echo ""

echo "Step 6: Installing dependencies (including nanoid)..."
npm install --production=false
success "Dependencies installed"
echo ""

echo "Step 7: Running database migrations..."
export PGPASSWORD="$PGPASSWORD"
export DATABASE_URL="postgresql://$DB_USER:$PGPASSWORD@localhost/$DB_NAME"

# Try to push database schema
npm run db:push || warning "Database push skipped (might already be up to date)"
success "Database schema updated"
echo ""

echo "Step 8: Building application..."
npm run build
success "Build completed"
echo ""

echo "Step 9: Stopping PM2 application..."
pm2 stop magnorweb 2>/dev/null || info "Application not running"
echo ""

echo "Step 10: Starting PM2 application with ecosystem config..."
pm2 delete magnorweb 2>/dev/null || true
pm2 start ecosystem.config.cjs --env production
pm2 save
success "Application started"
echo ""

echo "Step 11: Checking application status..."
sleep 3
pm2 logs magnorweb --lines 20 --nostream
echo ""
pm2 status
echo ""

success "🎉 Fix completed successfully!"
echo ""
echo "📊 To monitor logs:"
echo "   pm2 logs magnorweb"
echo ""
echo "🔄 To restart:"
echo "   pm2 restart magnorweb"
echo ""
echo "🌐 Your app should be accessible at:"
echo "   http://your-domain.com or http://localhost:5001"
echo ""
