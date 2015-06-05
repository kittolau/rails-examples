#!/bin/sh
#=============================
#Pull Application deployment
#=============================
cd ~/www/{{FULL_APP_NAME}}
git reset --hard

#setup for the first time
sudo chmod u+x {{APP_ROOT}}/config/deploy/{{STAGE}}/symlink/*

#cp production database.yml and secrets.yml
/bin/cp -rf {{APP_ROOT}}/config/deploy/{{STAGE}}/cp/database.yml {{APP_ROOT}}/config/
/bin/cp -rf {{APP_ROOT}}/config/deploy/{{STAGE}}/cp/secrets.yml {{APP_ROOT}}/config/

#restart unicorn
sudo /etc/init.d/unicorn_{{FULL_APP_NAME}} restart



