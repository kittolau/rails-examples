#!/bin/sh
#=============================
#Pull Application deployment
#=============================
cd ~/www/{{FULL_APP_NAME}}
git pull

#setup for the first time
cd {{APP_ROOT}}
RAILS_ENV={{RAILS_ENV_VAR}} rake db:migrate

#restart unicorn
sudo /etc/init.d/unicorn_{{FULL_APP_NAME}} restart



