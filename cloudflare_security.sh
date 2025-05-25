#!/bin/bash

# Enable Cloudflare DDoS Protection
curl -X POST "https://api.cloudflare.com/client/v4/zones/<YOUR_ZONE_ID>/settings/security_level" \
     -H "Authorization: Bearer ${{ secrets.CLOUDFLARE_API_KEY }}" \
     -H "Content-Type: application/json" \
     --data '{"value":"under_attack"}'

# Apply firewall rules
curl -X POST "https://api.cloudflare.com/client/v4/zones/<YOUR_ZONE_ID>/firewall/access_rules/rules" \
     -H "Authorization: Bearer ${{ secrets.CLOUDFLARE_API_KEY }}" \
     -H "Content-Type: application/json" \
     --data '{"mode":"block", "configuration":{"target":"ip", "value":"192.0.2.1"}, "notes":"Blocking suspicious traffic"}'

echo "✅ Cloudflare Security Enabled!"
