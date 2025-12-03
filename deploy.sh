#!/bin/bash
set -e

echo "🚀 MagnorWeb Deployment Script"
echo "================================"

# Variables
SERVER="64.227.23.152"
USER="root"
REMOTE_DIR="/var/www/magnorweb"
LOCAL_DIR="/Users/acar/MagnorWeb"

echo "📦 Creating deployment package..."
cd "$LOCAL_DIR"

# Create tarball excluding unnecessary files
tar -czf magnorweb-deploy.tar.gz \
  --exclude='node_modules' \
  --exclude='.git' \
  --exclude='dist' \
  --exclude='.DS_Store' \
  --exclude='*.log' \
  --exclude='data/' \
  .

echo "📤 Uploading to server..."
scp magnorweb-deploy.tar.gz ${USER}@${SERVER}:/tmp/

echo "🔧 Installing and building on server..."
ssh ${USER}@${SERVER} << 'ENDSSH'
set -e

echo "Creating directory..."
mkdir -p /var/www/magnorweb
cd /var/www/magnorweb

echo "Extracting files..."
tar -xzf /tmp/magnorweb-deploy.tar.gz

echo "Installing dependencies..."
npm install --production=false

echo "Building application..."
npm run build

echo "Restarting PM2..."
pm2 restart magnorweb || pm2 start ecosystem.config.cjs --env production

echo "Saving PM2 configuration..."
pm2 save

echo "Cleaning up..."
rm /tmp/magnorweb-deploy.tar.gz

ENDSSH

# Clean up local tarball
rm magnorweb-deploy.tar.gz

echo ""
echo "✅ Deployment completed successfully!"
echo "🌐 Your app should be running at: http://${SERVER}:5001"
echo ""
echo "📊 To check status, run:"
echo "   ssh ${USER}@${SERVER} 'pm2 status'"
echo ""
echo "📝 To view logs, run:"
echo "   ssh ${USER}@${SERVER} 'pm2 logs magnorweb'"
