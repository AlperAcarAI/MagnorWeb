# 🔧 Sunucuda Git Conflict Çözümü

## Sorun
ecosystem.config.cjs dosyasında merge conflict var.

## Hızlı Çözüm

### 1. Önce nano'dan çık
```bash
# Nano'da:
Ctrl+X  # Çık
N       # Kaydetme (save yapmayın)
```

### 2. Bizim versiyonu kullan (önerilen)
```bash
# Sunucuda çalıştır:
git checkout --theirs ecosystem.config.cjs
git add ecosystem.config.cjs
git commit -m "Merge: use new ecosystem.config"
```

### 3. GitHub'a push et ve pull
```bash
# Yerel bilgisayarınızda:
git add .
git commit -m "Fix ecosystem.config.cjs path"
git push origin main

# Sonra sunucuda:
git pull
npm run build
pm2 delete Magnor
pm2 start ecosystem.config.cjs --env production
pm2 save
```

---

## Alternatif: Manuel Düzeltme

Eğer nano'da düzeltmek isterseniz:

### ecosystem.config.cjs içeriği şöyle olmalı:

```javascript
module.exports = {
    "apps": [{
        "name": "magnorweb",
        "script": "dist/index.js",
        "cwd": "/var/www/MagnorWeb",  // ⚠️ DİKKAT: Büyük M
        "instances": 1,
        "autorestart": true,
        "watch": false,
        "max_memory_restart": "1G",
        "env": {
            "NODE_ENV": "production",
            "PORT": "5000"
        },
        "env_production": {
            "NODE_ENV": "production",
            "PORT": "5000"
        },
        "error_file": "/var/log/pm2/magnorweb-error.log",
        "out_file": "/var/log/pm2/magnorweb-out.log",
        "log_date_format": "YYYY-MM-DD HH:mm:ss Z"
    }]
};
```

Nano'da:
1. `<<<<<<< HEAD` satırından `=======` satırına kadar olanı SİL
2. `=======` satırını SİL
3. `>>>>>>> ...` satırını SİL
4. Sadece bizim versiyonu bırak
5. Ctrl+O (save), Enter, Ctrl+X (exit)

Sonra:
```bash
git add ecosystem.config.cjs
git commit -m "Resolve conflict in ecosystem.config.cjs"
npm run build
pm2 delete Magnor
pm2 start ecosystem.config.cjs --env production
pm2 save
```

---

## 🎯 En Kolay Yöntem

```bash
# 1. Conflict'i reset et
git reset --hard HEAD

# 2. Pull stratejisi belirle
git config pull.rebase false

# 3. Force pull (dikkatli!)
git fetch origin
git reset --hard origin/main

# 4. Build ve restart
npm run build
pm2 delete Magnor
pm2 start ecosystem.config.cjs --env production
pm2 save
pm2 status
```

---

## ⚠️ Önemli Notlar

- **Path:** `/var/www/MagnorWeb` (Büyük M ile!)
- Eski PM2 app ismi: **Magnor**
- Yeni PM2 app ismi: **magnorweb**
- Eski port: 5001
- Yeni port: 5000

PM2 delete Magnor yaptıktan sonra yeni "magnorweb" isimli app başlayacak.

---

## 🆘 Hala Çalışmıyorsa

```bash
# Sunucuda kontrol et:
cd /var/www/MagnorWeb
ls -la dist/index.js  # Dosya var mı?

# Yoksa build yap:
npm run build

# PM2'yi tamamen temizle ve yeniden başlat:
pm2 delete all
pm2 start ecosystem.config.cjs --env production
pm2 save
pm2 logs magnorweb
```
