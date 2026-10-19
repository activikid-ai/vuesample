#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
DEST="/var/www/html/vuesample"
OUT="${ROOT}/build-out"
BASE="/vuesample/"

cd "$ROOT"

echo "==> Installing dependencies..."
npm install

echo "==> Building (publicPath=${BASE})..."
# Use build-out so a root-owned dist/ cannot block rebuilds
rm -rf "$OUT"
npx vue-cli-service build --dest "$OUT"

echo "==> Deploying to ${DEST}..."
sudo mkdir -p "$DEST"
# Clear previous assets / workaround folders (may be owned by another user)
sudo rm -rf "${DEST}/js" "${DEST}/css" "${DEST}/bundle"
sudo rsync -a --delete "${OUT}/" "${DEST}/"

sudo tee "${DEST}/.htaccess" > /dev/null <<'EOF'
<IfModule mod_rewrite.c>
  RewriteEngine On
  RewriteBase /vuesample/
  RewriteRule ^index\.html$ - [L]
  RewriteCond %{REQUEST_FILENAME} !-f
  RewriteCond %{REQUEST_FILENAME} !-d
  RewriteRule . /vuesample/index.html [L]
</IfModule>
EOF

echo "==> Done. Open http://YOUR_SERVER/vuesample/"
echo "    Routes: /vuesample/kaza  /vuesample/ins  /vuesample/yer  /vuesample/zan"
ls -la "$DEST" "$DEST/js"
