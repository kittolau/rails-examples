#!/bin/sh
#============================
#This is intended for development enviroment to run
#============================
git remote add {{STAGE}}_{{SERVER_IP}} {{DEPLOY_USER}}@{{STAGE}}_{{SERVER_IP}}:/home/{{DEPLOY_USER}}/repo/{{FULL_APP_NAME}}.git
git push {{STAGE}}_{{SERVER_IP}} master
