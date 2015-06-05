#create symlink
sudo ln -nfs /home/deploy/www/helpAround_production/symlink/nginx.conf /etc/nginx/sites-enabled/helpAround_production
sudo ln -nfs /home/deploy/www/helpAround_production/symlink/unicorn_init.sh /etc/init.d/unicorn_helpAround_production
chmod +x /home/deploy/www/helpAround_production/symlink/unicorn_init.sh
