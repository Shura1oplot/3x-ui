#!/usr/bin/env bash

set -euo pipefail

cd /tmp

go install -v github.com/v2fly/geoip@latest

geoip=${GOPATH:-$HOME/go/bin}/geoip

curl -fsSL -o ipinfo_lite.json.gz \
    "https://ipinfo.io/data/ipinfo_lite.json.gz?_src=frontend&token=$IPINFO_TOKEN"

gunzip ipinfo_lite.json.gz

jq -r 'select(.country_code=="RU").network' ipinfo_lite.json >./ruall.txt

cat << EOF >./config.json
{
  "input": [
    {
      "type": "text",
      "action": "add",
      "args": {
        "name": "ruall",
        "uri": "./ruall.txt"
      }
    }
  ],
  "output": [
    {
      "type": "v2rayGeoIPDat",
      "action": "output"
    }
  ]
}
EOF

"$geoip"

cp /tmp/output/dat/geoip.dat /app/build/bin/geoip_RUALL.dat
