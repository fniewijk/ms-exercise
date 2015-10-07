#!/bin/bash

# Increase file descriptor limit on OSX.
ulimit -n 2560

# Install Node packages and ensure they are in the path.
npm install
PATH=node_modules/.bin:$PATH
export PATH

# WebPack watches and re-compiles all the front end code.
webpack --config webpack.dev.config.js app/main.coffee build/app.js -d --watch
