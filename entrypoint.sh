#!/bin/sh

if [ ! -d "node_modules" ]; then
  echo "node_modules not found, installing..."
  npm install
fi

exec "$@"
