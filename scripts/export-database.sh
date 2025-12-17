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

# Veritabanı bilgileri
DB_NAME="${DB_NAME:-magnorweb}"
DB_USER="${DB_USER:-postgres}"
DB_HOST="${DB_HOST:-localhost}"

echo "📋 Dump Bilgileri:"
echo "   Database: $DB_NAME"
echo "   User: $DB_USER"
echo "   Host: $DB_HOST"
echo "   Output: $DUMP_FILE"
echo ""

# Dump al
echo "🔄 Dump alınıyor..."
pg_dump -U "$DB_USER" -h "$DB_HOST" -d "$DB_NAME" > "$DUMP_FILE"

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
