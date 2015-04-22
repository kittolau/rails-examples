#install
  #rsepc --init
  #OR rails generate rspec:install

# rails generate rspec:model widget
  # will create a new spec file in spec/models/widget_spec.rb.

  # The same generator pattern is available for all specs:

  # scaffold
  # model
  # controller
  # helper
  # view
  # mailer
  # observer
  # integration
  # feature
  # job

#test db migration
  # rake db:migrate RAILS_ENV=test

#run all tests
  #rake spec to
  #bundle exec rspec

#run single tests
  # rspec spec/controllers/post_controller_spec.rb
