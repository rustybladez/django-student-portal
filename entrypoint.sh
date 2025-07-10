#!/bin/sh

# This script is a best practice for container startup.
# It waits for the database to be ready, applies migrations,
# and then starts the main application process.

echo "Applying database migrations..."
python manage.py migrate

echo "Starting server..."
# Execute the command passed to this script, or run the default runserver command
exec "$@"