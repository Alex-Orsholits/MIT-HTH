#!/bin/bash

git remote update

if git status -uno | grep "Your branch is behind"
        then 
                git pull origin main 
                pm2 restart easyrtc-server
fi
