#Capistrano uses a folder called shared to manage files and directories that should persist across releases.
#The key one is shared/config which contains configuration files which are required to persist across deploys.

#This approach aims is to keep as much common configuration in config/deploy.rb as possible and
#put only minimal stage specific configuration in the stage files like config/deploy/production.rb.

# Use Capistrano for deployment, put these in gem file
gem 'unicorn'

group :development do
  gem 'capistrano', '~> 3.1'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rvm'
end

#in console:
  #bundle
  #cap install

#deployment
  #When you run cap some_stage_name some_task,
  #Capistrano will look for a file config/deploy/some_stage_name.rb and load it after deploy.rb.
    #cap production deploy:setup
    #cap production deploy:setup_config


#show capistrano available tasks
  #cap -t
#show task detail
  #cap -e <taskname>


