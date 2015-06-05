#=============================
#Nginx SETUP PART
#=============================
#remove {{FULL_APP_NAME}}'s nginx.conf from enabled site
if [ -f /etc/nginx/sites-enabled/{{FULL_APP_NAME}} ]
then
  sudo rm /etc/nginx/sites-enabled/{{FULL_APP_NAME}}
  echo "removed {{FULL_APP_NAME}} Nginx Virtualhost"
else
  echo "No {{FULL_APP_NAME}} Nginx Virtualhost to remove"
fi

#restart nginx server
sudo service nginx restart

#=============================
#UNICORN SETUP PART
#=============================
#stop unicorn
sudo /etc/init.d/unicorn_{{FULL_APP_NAME}} stop

if [ -f /etc/init.d/unicorn_{{FULL_APP_NAME}} ]
then
  sudo rm /etc/init.d/unicorn_{{FULL_APP_NAME}}
  echo "removed unicorn_{{FULL_APP_NAME}} from init.d"
else
  echo "No unicorn_{{FULL_APP_NAME}} exist in init.d"
fi


