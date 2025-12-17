# PostgreSQL Extension Bağlantı Bilgileri

## VS Code PostgreSQL Extension ile Bağlanma

### 1. Extension Kurulumu
Eğer henüz yoksa VS Code'da PostgreSQL extension'ı yükleyin:
- Extension ID: `ckolkman.vscode-postgres`
- Veya: `Chris Kolkman - PostgreSQL`

### 2. Bağlantı Bilgileri

#### Local Development Database (Magnor DB)

```
Host: localhost
Port: 5432
Database: magnor_db
Username: acar (sistem kullanıcı adınız)
Password: (boş bırakabilirsiniz - local için genelde şifre gerekmez)
SSL: Disable
```

#### Connection String:
```
postgresql://localhost:5432/magnor_db
```

### 3. VS Code PostgreSQL Extension'da Bağlantı Oluşturma

1. VS Code'da PostgreSQL simgesine tıklayın (sol sidebar)
2. "Add Connection" veya "+" butonuna tıklayın
3. Aşağıdaki bilgileri girin:

   - **Hostname**: `localhost`
   - **PostgreSQL user**: `acar` (veya `whoami` komutunun çıktısı)
   - **Password**: Boş bırakın (Enter'a basın)
   - **Port**: `5432`
   - **Use SSL?**: `Standard Connection`
   - **Database**: `magnor_db`
   - **Display name**: `Magnor DB - Local`

4. "Connect" butonuna tıklayın

### 4. Veritabanını Keşfet

Bağlandıktan sonra:
- **Tables** klasörünü genişleterek 13 tablonuzu görebilirsiniz
- Her tabloya sağ tıklayıp:
  - `Show Table` - Verileri görüntüle
  - `Run Query` - SQL sorguları çalıştır
  - `Describe Table` - Tablo yapısını incele

### 5. Örnek SQL Sorguları

#### Tüm tabloları listele:
```sql
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public'
ORDER BY table_name;
```

#### Sosyal medya platformlarını görüntüle:
```sql
SELECT * FROM social_media;
```

#### Dilleri görüntüle:
```sql
SELECT * FROM languages;
```

#### KOL'ları tier score'a göre listele:
```sql
SELECT id, name, tier_score, email, telegram_address 
FROM kols 
WHERE is_active = true 
ORDER BY tier_score DESC;
```

#### Tablo yapısını incele:
```sql
SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_name = 'kols'
ORDER BY ordinal_position;
```

---

## Alternatif: pgAdmin veya DBeaver

### pgAdmin Bağlantısı:
1. pgAdmin'i açın
2. Sağ tıklayın: Servers → Register → Server
3. General tab:
   - Name: `Magnor DB Local`
4. Connection tab:
   - Host: `localhost`
   - Port: `5432`
   - Database: `magnor_db`
   - Username: `acar`

### DBeaver Bağlantısı:
1. Database → New Database Connection
2. PostgreSQL seçin
3. Host: `localhost`
4. Port: `5432`
5. Database: `magnor_db`
6. Username: sistem kullanıcınız

---

## Production Database (Neon) - Gelecek için

Production'da Neon kullanacaksanız:

1. [Neon Console](https://console.neon.tech) → Connection String
2. VS Code PostgreSQL Extension'da yeni bağlantı:
   - Hostname: `ep-xxx-xxx.region.neon.tech`
   - Port: `5432`
   - Database: `magnordb`
   - Username: Neon'dan alınan username
   - Password: Neon'dan alınan password
   - SSL: **Enable** (Required)

---

## Yararlı PostgreSQL Komutları (Terminal)

```bash
# Database'e bağlan
psql magnor_db

# Tüm tabloları listele
\dt

# Tablo yapısını göster
\d kols

# SQL dosyası çalıştır
psql magnor_db < migrations/0000_violet_justice.sql

# Database dump al (backup)
pg_dump magnor_db > backup.sql

# Database'i geri yükle
psql magnor_db < backup.sql

# Bağlantıyı kes
\q
```

---

## Troubleshooting

### "Connection refused" hatası:
```bash
# PostgreSQL servisinin çalıştığını kontrol edin
brew services list | grep postgresql

# Çalışmıyorsa başlatın
brew services start postgresql@15
```

### "Database does not exist" hatası:
```bash
# Database'i tekrar oluşturun
createdb magnor_db
```

### "Role does not exist" hatası:
```bash
# Kullanıcı oluşturun
createuser -s acar
```

---

**Not:** VS Code PostgreSQL Extension ile bağlandıktan sonra, Drizzle Studio ile aynı verileri göreceksiniz. İkisi de aynı veritabanına bağlanır.
