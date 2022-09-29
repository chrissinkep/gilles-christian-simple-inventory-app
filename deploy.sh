#!/bin/bash -ex
# output user data logs into a separate file for debugging
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
sudo apt update
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
. ~/.nvm/nvm.sh
nvm install --lts
nvm use 10
mkdir app
cd app
git clone https://github.com/chrissinkep/simple-inventory-app.git .
sudo chmod -R 755 .
npm run build:production
npm run start:production
npm install pm2@latest -g
export NODE_ENV=production && pm2 start backend/server.js
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8080 # 8080 -> 8080
