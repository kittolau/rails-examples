#!/bin/sh
#================================
#turn this project to be git before run this script
#===============================

##generate a deploy key
#ssh-keygen -t rsa

# SERVER_ROOT_PRIVATE_KEY_LOCATION=/vagrant/key/serverrootkey
# #vagrant cp root key to ~/.ssh
# #notice putty need to export OpenSSL key
# cp $SERVER_ROOT_PRIVATE_KEY_LOCATION ~/.ssh
# chmod 600 ~/.ssh/serverkey
# eval `ssh-agent -s`
# ssh-add ~/.ssh/serverkey

#make all file in local folder executable
chmod +x -R ./local

#create deploy user on remote server
#ssh root@{{SERVER_IP}} 'bash -s' < ./server/create_deploy_user.sh

#cp public key to deploy user account
#cat {{DEPLOY_USER_PUBLIC_KEY_LOCATION}} | ssh root@{{SERVER_IP}} "mkdir -p /home/deploy/.ssh && cat >>  /home/deploy/.ssh/authorized_keys"

#add private key to curent user
./local/add_private_key_to_current_user.sh

#create remote repo
ssh {{DEPLOY_USER}}@{{STAGE}}_{{SERVER_IP}} 'bash -s' < ./server/remote_repo_create.sh

#add and push to remote repo
./local/git_add_remote_repo.sh

#setup the application
ssh {{DEPLOY_USER}}@{{STAGE}}_{{SERVER_IP}} 'bash -s' < ./server/application_setup.sh
