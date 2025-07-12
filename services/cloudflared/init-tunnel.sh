#!/bin/bash

TUNNEL_ID_FILE=$(find ./services/cloudflared/config -name "*.json" | head -n 1)

if [ -z "$TUNNEL_ID_FILE" ]; then
  echo "❌ No tunnel credentials file found in ./services/cloudflared/config/"
  echo "To set up the Cloudflare Tunnel for the first time, follow these steps:"
  echo ""
  echo "1. Run the following on your host (requires 'cloudflared' installed):"
  echo ""
  echo "   cloudflared tunnel login"
  echo "   cloudflared tunnel create blorakitron"
  echo ""
  echo "2. This will generate a file like ~/.cloudflared/<TUNNEL_ID>.json"
  echo ""
  echo "3. Copy that file into:"
  echo "   ./services/cloudflared/config/<TUNNEL_ID>.json"
  echo ""
  echo "4. Then update 'config.yml' with the correct tunnel ID."
  echo ""
  echo "Once this is done, you can run the tunnel via Docker:"
  echo "   docker compose up -d cloudflared"
  echo ""
else
  echo "✅ Found credentials file: $TUNNEL_ID_FILE"
  echo "You're ready to start the tunnel with:"
  echo "   docker compose up -d cloudflared"
fi
