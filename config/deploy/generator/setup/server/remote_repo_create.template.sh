#!/bin/sh
#This is intended for deploy user to run
#============================
#Create bare git repo for deployment
#============================
mkdir -p ~/repo/{{FULL_APP_NAME}}.git && cd ~/repo/{{FULL_APP_NAME}}.git
git --bare init

#============================
#Create git clone for pulling bare repo
##============================
mkdir -p ~/www/ && cd ~/www/
git clone file:///home/{{DEPLOY_USER}}/repo/{{FULL_APP_NAME}}.git
