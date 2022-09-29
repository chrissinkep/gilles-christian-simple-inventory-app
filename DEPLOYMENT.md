username: candidate-gilles.christian
api name: gilles.christian
api key: 010097069788a1dcdf025a61f0a67c3fa254305e
repo link: git@gitea.scopicsoftware.com:scopic-interviewing/gilles-christian-simple-inventory-app.git

AWS PW: h5gziptsj5x6669

security
security 1: set password on res

aws_db_name = gilles-db-tier
aws_db_password = P6JBO25c0bW&

2: security 2 no public access to ads just in vpc

3: gilles-db-tier.czdsnotlnwwp.ap-southeast-1.rds.amazonaws.com, onlz ec2 can access

4: add .env


low cost
1. database free offer
2. cost optimization with billing alert


# GIT ACCESS
echo "# simple-inventory-app" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/chrissinkep/simple-inventory-app.git
git push -u origin main
- deployment process


# install nodejs on ec2
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


# copy public key to server
mkdir app
scp file.txt ubuntu@10.10.0.2:/home/ubuntu
scp -i gilles-akey.pem gilles.christian.pem ubuntu@ec2-18-143-146-57.ap-southeast-1.compute.amazonaws.com:app
# send directory
scp -i ../../gilles-akey.pem -r public/ ubuntu@ec2-18-143-146-57.ap-southeast-1.compute.amazonaws.com:app/gilles-christian-simple-inventory-app/frontend


# correct private and public key:  
chmod 600 *.pem *.ppk

# clone private repo: 
git -c core.sshCommand="ssh -i gilles.christian.pem" clone git@gitea.scopicsoftware.com:scopic-interviewing/gilles-christian-simple-inventory-app.git


# install dependencys on backend
cd backend
npm i
npm i bcrypt
npm i pm2
npm i cross-env

# install dependencys on frontend
cd backend
npm i
npm i bcrypt
npm i pm2 
npm i cross-env


# port forwading usin NAT
sudo iptables -t nat -L
sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8080 # 8080 -> 8080

# run server in background
npm install pm2@latest -g
export NODE_ENV=production && pm2 start server.js
# pm2 delete server.js
pm2 delete <daemon id>




