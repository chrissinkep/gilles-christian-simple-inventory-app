#!/bin/bash
echo "=====================Cosole ouput CdOut======================="
sudo exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
echo "=====================update apt packages======================="
sudo apt update
echo "=====================install Nodejs======================="
export NVM_DIR="$HOME/.nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
. ~/.nvm/nvm.sh
nvm install 10
nvm use 10
echo "=====================Build Production code======================="
npm run build:production
npm i cross-env
echo "=====================Install pm2======================="
npm install pm2@latest -g
export NODE_ENV=production && pm2 start backend/server.js
echo "=====================http forwarding using NAT======================="
sudo iptables -t nat -L
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8080 # 8080 -> 8080
