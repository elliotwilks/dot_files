#!/bin/bash

# Define variables
LOCAL_DIR=~/Public/personal_site/
REMOTE_USER=root
REMOTE_HOST=elliotwilks.site
REMOTE_DIR=/var/www/mysite/

# Sync files using rsync
rsync -avz --delete "$LOCAL_DIR" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR"

# Set correct permissions (optional)
ssh "$REMOTE_USER@$REMOTE_HOST" "chown -R www-data:www-data $REMOTE_DIR"

echo "Deployment complete!"

