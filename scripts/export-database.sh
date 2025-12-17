#!/bin/bash

# MagnorWeb - Veritabanı Export Script
# Bu script yerel veritabanınızdan dump alır

set -e

echo "🗄️  MagnorWeb - Database Export"
echo "================================"
echo ""

# Dump dosyası adı (timestamp ile)
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
DUMP_FILE="magnorweb_dump_${TIMESTAMP}.sql"

# .env dosyasından DATABASE_URL'i oku
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

# DATABASE_URL'den database adını parse et
if [ -n "$DATABASE_URL" ]; then
    # postgresql://[user[:password]@][host][:port]/database formatından parse
    # Önce @ işareti var mı kontrol et (kullanıcı adı var mı?)
    if [[ "$DATABASE_URL" == *"@"* ]]; then
        # Kullanıcı adı var
        DB_NAME=$(echo $DATABASE_URL | sed -n 's#.*\/\([^?]*\).*#\1#p')
        DB_HOST=$(echo $DATABASE_URL | sed -n 's#.*@\([^:/]*\).*#\1#p')
        DB_USER=$(echo $DATABASE_URL | sed -n 's#.*://\([^:@]*\).*#\1#p')
    else
        # Kullanıcı adı yok, sadece host:port/database formatı
        DB_NAME=$(echo $DATABASE_URL | sed -n 's#.*\/\([^?]*\).*#\1#p')
        DB_HOST=$(echo $DATABASE_URL | sed -n 's#.*://\([^:/]*\).*#\1#p')
        DB_USER=$(whoami)
    fi
    
    # Varsayılan host
    [ -z "$DB_HOST" ] && DB_HOST="localhost"
else
    # Varsayılan değerler
    DB_NAME="${DB_NAME:-magnorweb}"
    DB_USER=$(whoami)
    DB_HOST="${DB_HOST:-localhost}"
fi

echo "📋 Dump Bilgileri:"
echo "   Database: $DB_NAME"
echo "   User: $DB_USER"
echo "   Host: $DB_HOST"
echo "   Output: $DUMP_FILE"
echo ""

# Dump al
echo "🔄 Dump alınıyor..."
# macOS'ta genellikle kullanıcı adı belirtmeye gerek yok
pg_dump -h "$DB_HOST" -d "$DB_NAME" > "$DUMP_FILE" 2>&1

if [ $? -eq 0 ]; then
    FILE_SIZE=$(du -h "$DUMP_FILE" | cut -f1)
    echo "✅ Dump başarıyla oluşturuldu!"
    echo "   Dosya: $DUMP_FILE"
    echo "   Boyut: $FILE_SIZE"
    echo ""
    echo "📤 Sunucuya göndermek için:"
    echo "   scp $DUMP_FILE root@SUNUCU_IP:/var/www/magnorweb/"
else
    echo "❌ Dump alınamadı!"
    exit 1
fi
