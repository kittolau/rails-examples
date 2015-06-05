#!/bin/sh
sudo su
# to del user
# userdel -r deploy
#============================
#Create deploy user
DEPLOY_USER={{DEPLOY_USER}}
DEPLOY_USER_PASSWORD={{DEPLOY_USER}}
#============================
#create deploy user
adduser --disabled-password --gecos "" ${DEPLOY_USER}
#add deploy to sudoer
sudo adduser ${DEPLOY_USER} sudo
#change password for deploy user
echo "${DEPLOY_USER}:${DEPLOY_USER_PASSWORD}" | chpasswd

#crreate .ssh folder
mkdir -p /home/${DEPLOY_USER}/.ssh
chmod 700 /home/${DEPLOY_USER}/.ssh

#change home file owned by deploy user
chown ${DEPLOY_USER}:${DEPLOY_USER} /home/${DEPLOY_USER} -R

#add %sudo if sudoers does not exist
if grep -q '^%sudo' "/etc/sudoers"; then
   echo "%sudo exists in sudoers, skip adding..."
else
   echo "%sudo does not exists in sudoers, adding..."
   chmod u+w /etc/sudoers
   echo "%sudo   ALL=(ALL:ALL) ALL" >> /etc/sudoers
   chmod u-w /etc/sudoers
fi

#add passwordless %{{DEPLOY_USER}}
if grep -q '^%{{DEPLOY_USER}}' "/etc/sudoers"; then
   echo "%{{DEPLOY_USER}} exists in sudoers, skip adding passwordless %{{DEPLOY_USER}} ..."
else
   echo "%{{DEPLOY_USER}} does not exists in sudoers, adding passwordless %{{DEPLOY_USER}} ..."
   chmod u+w /etc/sudoers
   echo "%{{DEPLOY_USER}}   ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers
   chmod u-w /etc/sudoers
fi

#turnoff ssh password authentication
if grep -q '^PasswordAuthentication' "/etc/ssh/sshd_config"; then
   echo "PasswordAuthentication is turned on , turning off..."
   sed -i 's/^PasswordAuthentication/#PasswordAuthentication/g' /etc/ssh/sshd_config
else
   echo "PasswordAuthentication is not turned on , skipping..."
fi
