#!/bin/sh
#================================
#turn this project to be git before run this script
#===============================

#update server code
ssh {{DEPLOY_USER}}@{{STAGE}}_{{SERVER_IP}} 'bash -s' < ./server/hard_reset_repo.sh

