#!/bin/bash

# Install Composer Libraries
composer install --no-interaction --no-dev --no-plugins --no-scripts
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to Install Composer Libraries: $status"
  exit $status
fi
echo "Composer Libraries Installed"

# Install Node Packages
npm install
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to Install Node Packages: $status"
  exit $status
fi
echo "Node Packages Installed"

# Run the build
npm run production

# Launch Supervisord
supervisord -n -c /etc/supervisor/conf.d/supervisord.conf
