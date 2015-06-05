#!/bin/sh
#================================
#turn this project to be git before run this script
#===============================

#make all file in local folder executable
chmod +x -R ./local

#push to remote server
./local/git_push_master_branch.sh

#update server code
ssh {{DEPLOY_USER}}@{{STAGE}}_{{SERVER_IP}} 'bash -s' < ./server/update_server_code.sh

