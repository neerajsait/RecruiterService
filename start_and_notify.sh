#!/bin/bash
# start_and_notify.sh - Script to run the app and notify you of the URL

# 1. Start the Docker Compose stack in the background
echo "Starting application and Cloudflare Tunnel..."
sudo docker-compose up -d

# 2. Wait for Cloudflare to generate the URL
echo "Waiting for Cloudflare to generate the URL (this takes a few seconds)..."
sleep 10

# 3. Extract the URL from the tunnel logs
# This grabs the last trycloudflare.com URL printed in the logs
URL=$(sudo docker-compose logs tunnel | grep -o 'https://[a-zA-Z0-9-]*\.trycloudflare\.com' | tail -1)

if [ -z "$URL" ]; then
    echo "Could not find the URL yet. You can check manually by running: sudo docker-compose logs tunnel"
    exit 1
fi

echo ""
echo "=================================================="
echo "🎉 SUCCESS! Your application is live at:"
echo "👉 $URL"
echo "=================================================="
echo ""

# 4. (Optional) Send an email notification using Resend (resend.com)
# Load variables securely from .env file
if [ -f .env ]; then
    set -a
    source .env
    set +a
fi

if [ -n "$RESEND_API_KEY" ] && [ -n "$TO_EMAIL" ]; then
    echo "Sending email notification via Resend..."
    curl -X POST 'https://api.resend.com/emails' \
         -H "Authorization: Bearer $RESEND_API_KEY" \
         -H "Content-Type: application/json" \
         -d '{
              "from": "onboarding@resend.dev",
              "to": "'$TO_EMAIL'",
              "subject": "🚀 Server Started! New Cloudflare URL",
              "html": "<p>Your application is live! The new URL is: <strong><a href=\"'$URL'\">'$URL'</a></strong></p>"
            }'
    echo -e "\nEmail notification sent!"
fi

# 5. Pull any remote changes first so working tree is clean
git pull origin master

# 6. Write the new Cloudflare URL to the JSON file
mkdir -p docs
echo "{\"url\": \"$URL\"}" > docs/tunnel-url.json

# 7. Push to GitHub if the URL actually changed
git add docs/tunnel-url.json
if ! git diff --cached --quiet; then
    git commit -m "chore: update live tunnel URL [skip ci]"
    git push origin master
    echo "Pushed updated URL to GitHub Pages!"
else
    echo "URL has not changed, skipping git push."
fi
