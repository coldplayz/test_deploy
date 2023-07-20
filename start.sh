#!/usr/bin/env bash
# Production start script for the project - Latent

# Run backend server and job queue in background
# TODO: log rotation
if [[ ! $(pgrep -f jobs/processJobs) ]]
then
  node ./backend/api/v1/jobs/processJobs.js > queue.log &
fi

if [[ ! $(pgrep -f server.js) ]]
then
  node ./backend/api/v1/server.js > server.log &
fi

# Run frontend app
if [[ ! $(pgrep -f vite) ]]
then
  npm run f-dev > frontend.log &
fi

# Wait for back- and front-ends to start
sleep 8  # too much?
