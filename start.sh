#!/usr/bin/env bash
# Production start script for the project - Latent

# Run backend server and job queue in background
# TODO: log rotation
if [[ ! $(pgrep -f jobs/processJobs) ]]
then
  node ./backend/api/v1/jobs/processJobs.js &
fi

if [[ ! $(pgrep -f server.js) ]]
then
  node ./backend/api/v1/server.js &
fi

sleep 4

# Run frontend app
if [[ ! $(pgrep -f vite) ]]
then
  vite --root Latent-FrontEnd --port 3000 --logLevel info --debug true
fi
