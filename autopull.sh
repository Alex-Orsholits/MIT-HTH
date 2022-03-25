#!/bin/bash

git remote update

if git status -uno | grep "Your branch is behind"
        then git pull && pm2 restart easyrtc-server
fi
