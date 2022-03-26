## Amazon AWS setup

As stated in the readme, the selected EC2 instance is an x86 t3.micro deployment with Ubuntu 20.04LTS server selected as the OS. Other deployments are of course possible. 

### AWS firewall settings
The ports need to be allowed for ingress:
 - (SSH port 22 - this is enabled by default)
 - TCP port 80
 - TCP port 443
 - UDP ports 51610-65535

## Getting started
Once you are connected to your new AWS instance via SSH, clone this repository to the home directory

`` git clone https://github.com/Reality-Hack-2022/TEAM-56.git ``

We also recommend updating the server deployment with

``sudo apt update && sudo apt upgrade``

### Required dependencies for bare minimum setup
 - npm (also installs nodejs) ``sudo apt install npm``
 - pm2 (``npm install pm2 -g``)
 - NGINX (``sudo apt install nginx``)

cd to the server directory and run 

``pm2 start easyrtc-server.js``

then run 

``pm2 startup`` and finally ``pm2 save``

pm2 helps us manage the server application and ensures it restarts with the deployment. 
More info on pm2 can be found [here](https://pm2.keymetrics.io/docs/usage/quick-start/)

If you have access to this Github repository, or a fork, you can use the ``autopull.sh`` script to pull the latest code and restart the nodejs server. 

You can also set it up as a cronjob by opening the crontab editor using 

``contrab -e``

and appending 
``* * * * * /bin/bash /home/ubuntu/TEAM-56/autopull.sh`` to the bottom of the file (this will check for code changes every minute)

### Configuring NGINX


## Setting up Janus
