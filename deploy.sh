#!/bin/bash -ex
echo "=====================Cosole ouput CdOut======================="
# output user data logs into a separate file for debugging
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
echo "=====================update apt packages======================="
sudo apt update
echo "=====================install Nodejs======================="
export NVM_DIR="$HOME/.nvm"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
. ~/.nvm/nvm.sh
#export NVM dir
export NVM_DIR="/.nvm"	
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"	
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" 
nvm install 10
nvm use 10
sudo apt update

echo "=====================Build Production code======================="
npm run build:production
npm i cross-env
echo "=====================Install pm2======================="
npm install pm2@latest -g
export NODE_ENV=production && pm2 start backend/server.js
echo "=====================http forwarding using NAT======================="
sudo iptables -t nat -L
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8080 # 8080 -> 8080
