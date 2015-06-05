#!/bin/sh
#added key for
if grep -q '^Host {{STAGE}}_{{SERVER_IP}}' ~/.ssh/config; then
   echo "Host {{STAGE}}_{{SERVER_IP}} Already exist, skip adding..."
else
    echo "Adding Host {{STAGE}}_{{SERVER_IP}} to ~/.ssh/config"

    echo "Host {{STAGE}}_{{SERVER_IP}}" >> ~/.ssh/config
    echo "  HostName {{SERVER_IP}}" >> ~/.ssh/config
    echo "  User {{DEPLOY_USER}}" >> ~/.ssh/config
    echo "  IdentityFile {{DEPLOY_USER_PRIVATE_KEY_LOCATION}}" >> ~/.ssh/config
    echo "  IdentitiesOnly yes" >> ~/.ssh/config
    echo ""
fi

