#!/bin/bash
# watchdog.sh - Runs every 5 minutes to check if the Cloudflare URL changed

cd /home/ubuntu/RecruiterService

# Load environment variables
if [ -f .env ]; then
  export $(cat .env | grep -v '#' | awk '/=/ {print $1}')
fi

# Get the latest URL from the docker logs
LATEST_URL=$(sudo docker-compose logs tunnel | grep -o 'https://[a-zA-Z0-9-]*\.trycloudflare\.com' | tail -n 1)
LAST_URL_FILE="/home/ubuntu/last_url.txt"

# Read the last known URL we sent an email about
if [ -f "$LAST_URL_FILE" ]; then
    LAST_URL=$(cat "$LAST_URL_FILE")
else
    LAST_URL=""
fi

# If the URL is new and not empty, send an email!
if [ "$LATEST_URL" != "" ] && [ "$LATEST_URL" != "$LAST_URL" ]; then
    # Save the new URL so we don't spam the email
    echo "$LATEST_URL" > "$LAST_URL_FILE"
    
    echo "URL changed to $LATEST_URL. Sending email..."
    
    # Send email using the Resend API
    curl -s -X POST "https://api.resend.com/emails" \
         -H "Authorization: Bearer $RESEND_API_KEY" \
         -H "Content-Type: application/json" \
         -d '{
            "from": "onboarding@resend.dev",
            "to": "2200030957cseh@gmail.com",
            "subject": "⚠️ Server Update: New Live URL",
            "html": "<p>Hello!</p><p>Cloudflare just reset your tunnel connection. Your Spring Boot server is still running safely in the background, but the link to access it has changed.</p><p>Your brand new live URL is: <br><br><strong><a href=\"'"$LATEST_URL"'\">'"$LATEST_URL"'</a></strong></p><p>Happy coding!</p>"
         }'
fi
