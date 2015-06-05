#!/bin/sh
#=============================
#Pull Application for first time Config
#=============================
cd ~/www/{{FULL_APP_NAME}}
git pull

#=============================
#Nginx SETUP PART
#=============================
#create symlink for nginix's sites-enabled
sudo ln -nfs {{APP_ROOT}}/config/deploy/{{STAGE}}/symlink/nginx.conf /etc/nginx/sites-enabled/{{FULL_APP_NAME}}

#remove default enabled site
if [ -f /etc/nginx/sites-enabled/default ]
then
  sudo rm /etc/nginx/sites-enabled/default
  echo "removed default Nginx Virtualhost"
else
  echo "No default Nginx Virtualhost to remove"
fi

#restart nginx server
sudo service nginx restart

#=============================
#UNICORN SETUP PART
#=============================
#create symlink for this app specific unicorn service
sudo ln -nfs {{APP_ROOT}}/config/deploy/{{STAGE}}/symlink/unicorn_init.sh /etc/init.d/unicorn_{{FULL_APP_NAME}}
chmod +x {{APP_ROOT}}/config/deploy/{{STAGE}}/symlink/unicorn_init.sh

#cp unicorn config file to rails's config folder
/bin/cp -rf {{APP_ROOT}}/config/deploy/{{STAGE}}/cp/unicorn.rb {{APP_ROOT}}/config/

#create writable pids directory for unicorn
mkdir -p {{APP_ROOT}}/tmp/pids

#=============================
#Rails Config
#=============================
#cp production database.yml and secrets.yml
/bin/cp -rf {{APP_ROOT}}/config/deploy/{{STAGE}}/cp/database.yml {{APP_ROOT}}/config/
/bin/cp -rf {{APP_ROOT}}/config/deploy/{{STAGE}}/cp/secrets.yml {{APP_ROOT}}/config/

#setup for the first time
cd {{APP_ROOT}}
bundle install
RAILS_ENV={{RAILS_ENV_VAR}} rake db:create
RAILS_ENV={{RAILS_ENV_VAR}} rake db:schema:load

#restart unicorn
sudo /etc/init.d/unicorn_{{FULL_APP_NAME}} restart



