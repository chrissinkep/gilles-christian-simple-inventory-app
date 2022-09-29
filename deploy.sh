#!/bin/bash
sudo exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo apt update
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
cd ~
. ~/.nvm/nvm.sh
cd ~
nvm install 10
nvm use 10
mkdir app
cd app
git clone https://github.com/chrissinkep/gilles-christian-simple-inventory-app.git .
npm i cross-env
npm install pm2@latest -g
export NODE_ENV=production && pm2 start backend/server.js
sudo iptables -t nat -L
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8080 # 8080 -> 8080
