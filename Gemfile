source 'https://rubygems.org'

source 'https://rubygems.org'

#Application Dependencies
#angular $templateCache using Rails asset pipeline
gem "angular-rails-templates"
#paging
gem "kaminari"
#advanced sorting and searching for activerecord
gem "ransack", github: 'activerecord-hackery/ransack', branch: 'rails-4.1'
#tagging
#gem "Acts-as-taggable-on"
#file upload
#gem "Paperclip"
#better form
#gem "simple_form"
#gem "formtastic"
#admin panel
#gem "ActiveAdmin"

#Debug Dependencies
group :development do
    #an IRB replacement
    gem 'pry'
    #getting pry in Rails console to replace IRB
    #can also use "show-routes --grep new", "show-models" in the console
    gem 'pry-rails'
    #Adds step, next, finish and continue commands and breakpoints to Pry using byebug. Only supoort Ruby 2+
    # adding "binding.pry" to use it
    gem 'pry-byebug'
    #the document used in console with "show-doc" command
    gem 'pry-doc'
    #adding support for remote debugging
    #gem 'pry-remote'
    #gem 'pry-stack_explorer'
    #better printing
    gem 'awesome_print'

    #replaces the standard Rails error page with a much better and more useful error page.
    #if using vagrant
    # insert the below code into environments/development.rb to by pass the ip filter
    #
    # if defined? BetterErrors
    #   BetterErrors::Middleware.allow_ip! "10.0.2.2"
    # end
    gem "better_errors"
    #  to enable the REPL and local/instance variable inspection in better_errors
    gem "binding_of_caller"
end

#Testing dependencies
#gem 'sass', '3.2.19'
group :test, :development do

  #BDD testing framewrok
  gem "rspec-rails", "~> 2.0"
  #better fixture loading
  gem "factory_girl_rails", "~> 4.0"
  #clean the database that does not support transaction
  gem "database_cleaner"

  #acceptence/browser test using selenium
  #gem "capybara"
  #gem "selenium-webdriver"
end

group :test do
  #run test on save, to use it:
  # guard init rspec
  # gem install rb-fsevent
  # guard
  gem "guard-rspec"
end

#front end Dependencies mangement
#bridging bower and rails
#gem 'bower-rails'
#used to pre populate the view such that you can even serve the view asset in CND without the need of Cross Origin Resource-Sharing
#gem 'angular-rails-templates'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.7'
# Use mysql as the database for Active Record
gem 'mysql2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]


