#/usr/bin/env bash

this=$(basename "$0")

for pid in $(pidof -x "${this}"); do
    if [ ${pid} != $$ ]; then
        echo "[$(date)] : ${this} : Process is already running with PID ${pid}"
        exit 1
    fi
done

# Check is it root else use sudo
if [ "$(whoami)" != "root" ]; then
    SUDO=sudo
fi

# Require curl and jq
if ! $(type curl > /dev/null 2>&1) ; then
    ${SUDO} apt install -y curl
fi
if ! $(type jq > /dev/null 2>&1) ; then
    ${SUDO} apt install -y jq
fi

# DDNS Parameters
myip=$(curl -Ls https://ifconfig.co/json | jq -r '.ip')
zone="YOUR_CLOUDFLARE_DNS_ZONE_ID"
name="YOUR_FULL_DOMAIN_NAME"
record="YOUR_CLOUDFLARE_DNS_RECORD_ID"
key="YOUR_CLOUDFLARE_API_KEY"
email="YOUR_CLOUDFLARE_API_EMAIL"

# CloudFlare DDNS API
# id Record ID
# type DNS record type
# name Full domain name
# content IP Address
# data Other data
# proxiable Is it can proxied with clousflare
# proxied Is it proxied with clousflare
curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/${zone}/dns_records/${record1}" \
-H "X-Auth-Email: ${email}" \
-H "X-Auth-Key: ${key}" \
-H "Content-Type: application/json" \
--data '{"id":"'${record}'","type":"A","name":"'${name}'","content":"'${myip}'","data":{},"proxiable": true, "proxied": true}' | jq -r '.' > ddns.json

exit 0
