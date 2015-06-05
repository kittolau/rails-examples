#!/bin/sh

#this is used for SSH to run script
SERVER_IP="202.171.212.107"
DEPLOY_USER_PRIVATE_KEY_LOCATION=/home/vagrant/.ssh/deploy_key
DEPLOY_USER_PUBLIC_KEY_LOCATION=/home/vagrant/.ssh/deploy_key.pub

# This is used in the Nginx VirtualHost to specify which domains
# the app should appear on. If you don't yet have DNS setup, you'll
# need to create entries in your local Hosts file for testing.
SERVER_NAME="helparound-stage.radcorner.com"

#deploy user to run unicorn and login
DEPLOY_USER=deploy

# used in case we're deploying multiple versions of the same
# app side by side. Also provides quick sanity checks when looking
# at filepaths

#MUST BE SAME WITH rails app name
APP=helpAround
STAGE=stage

#APP secrets
SECRET=2b2ee9444a07a41a2e6155e0abc062418c925be251bcfc6533e29138e418a0c518b7e5b1e8176d5fed7db5bce3a45a633af7240adaa909b55ba705b11893903f

#SSL Option
#to use SSL, let this variable being blank
SSL=##SSL##

#=============================================
#Not modify the following variable
#=============================================
FULL_APP_NAME="${APP}_${STAGE}"
APP_ROOT=/home/${DEPLOY_USER}/www/${FULL_APP_NAME}
#used for unicorn to run and rake migration
RAILS_ENV_VAR=${STAGE}

subsitute_var (){
  INPUT_FILE=$1
  EXPORT_FILE=$2
  sed -e "s@{{SERVER_IP}}@${SERVER_IP}@ig" \
    -e "s@{{SERVER_NAME}}@${SERVER_NAME}@ig" \
    -e "s@{{FULL_APP_NAME}}@${FULL_APP_NAME}@ig" \
    -e "s@{{APP_ROOT}}@${APP_ROOT}@ig" \
    -e "s@{{RAILS_ENV_VAR}}@${RAILS_ENV_VAR}@ig" \
    -e "s@{{DEPLOY_USER}}@${DEPLOY_USER}@ig" \
    -e "s@{{STAGE}}@${STAGE}@ig" \
    -e "s@{{SECRET}}@${SECRET}@ig" \
    -e "s@{{DEPLOY_USER_PRIVATE_KEY_LOCATION}}@${DEPLOY_USER_PRIVATE_KEY_LOCATION}@ig" \
    -e "s@{{DEPLOY_USER_PUBLIC_KEY_LOCATION}}@${DEPLOY_USER_PUBLIC_KEY_LOCATION}@ig" \
    -e "s@##SSL##@${SSL}@ig" $INPUT_FILE > $EXPORT_FILE
}

mkdir -p ../${STAGE}/symlink/
mkdir -p ../${STAGE}/cp/
mkdir -p ../${STAGE}/setup/server
mkdir -p ../${STAGE}/setup/local
mkdir -p ../${STAGE}/deploy/server
mkdir -p ../${STAGE}/deploy/local

subsitute_var ./cp/unicorn.template.rb ../${STAGE}/cp/unicorn.rb
subsitute_var ./cp/database.template.yml ../${STAGE}/cp/database.yml
subsitute_var ./cp/secrets.template.yml ../${STAGE}/cp/secrets.yml

subsitute_var ./deploy/server/hard_reset_repo.template.sh ../${STAGE}/deploy/server/hard_reset_repo.sh
subsitute_var ./deploy/server/update_server_code.template.sh ../${STAGE}/deploy/server/update_server_code.sh
subsitute_var ./deploy/local/git_push_master_branch.template.sh ../${STAGE}/deploy/local/git_push_master_branch.sh
subsitute_var ./deploy/one_click_deploy.template.sh ../${STAGE}/deploy/one_click_deploy.sh
subsitute_var ./deploy/hard_reset_repo.template.sh ../${STAGE}/hard_reset_repo.sh

subsitute_var ./setup/local/add_private_key_to_current_user.template.sh ../${STAGE}/setup/local/add_private_key_to_current_user.sh
subsitute_var ./setup/local/git_add_remote_repo.template.sh ../${STAGE}/setup/local/git_add_remote_repo.sh
subsitute_var ./setup/server/application_setup.template.sh ../${STAGE}/setup/server/application_setup.sh
subsitute_var ./setup/server/create_deploy_user.template.sh ../${STAGE}/setup/server/create_deploy_user.sh
subsitute_var ./setup/server/remote_repo_create.template.sh ../${STAGE}/setup/server/remote_repo_create.sh
subsitute_var ./setup/one_click_setup.template.sh ../${STAGE}/setup/one_click_setup.sh

subsitute_var ./symlink/nginx.template.conf ../${STAGE}/symlink/nginx.conf
subsitute_var ./symlink/unicorn_init.template.sh ../${STAGE}/symlink/unicorn_init.sh
