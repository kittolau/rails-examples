# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'

#load all the support file inside the spec/support
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

#confirm that the test db is same with dev
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  #randomize the test order
  config.order = "random"
  #infer the type from the file folder
  config.infer_spec_type_from_file_location!
end
