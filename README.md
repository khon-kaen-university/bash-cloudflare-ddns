# bash-cloudflare-ddns
Update cloudflare DNS using bash curl and jq

Get cloudflare Global API Key from your cloudflare account profile\
https://dash.cloudflare.com/profile

# Get your user's ID
curl -X GET "https://api.cloudflare.com/client/v4/user" `\`\
     -H "X-Auth-Email: YOUR_CLOUDFLARE_EMAIL" `\`\
     -H "X-Auth-Key: YOUR_CLOUDFLARE_API_KEY" `\`\
     -H "Content-Type: application/json" | jq -r '.'
     
# Get your Zone's ID
curl -X GET "https://api.cloudflare.com/client/v4/zones?account.id=YOUR_ACCOUNT_ID_FROM_ABOVE" `\`  
     -H "X-Auth-Email: YOUR_CLOUDFLARE_EMAIL" `\`\
     -H "X-Auth-Key: YOUR_CLOUDFLARE_API_KEY" `\`\
     -H "Content-Type: application/json" | jq -r '.'
     
# Get your Record's ID
curl -X GET "https://api.cloudflare.com/client/v4/zones/YOUR_ZONE_ID_FROM_ABOVE/dns_records" `\`\
     -H "X-Auth-Email: YOUR_CLOUDFLARE_EMAIL" `\`\
     -H "X-Auth-Key: YOUR_CLOUDFLARE_API_KEY" `\`\
     -H "Content-Type: application/json" | jq -r '.'
