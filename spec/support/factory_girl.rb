require 'factory_girl'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  #http://www.rubydoc.info/gems/factory_girl/file/GETTING_STARTED.md

  # factory will be automatically loaded if they are defined in files at the following locations:
  # test/factories.rb
  # spec/factories.rb
  # test/factories/*.rb
  # spec/factories/*.rb

  #using database_cleaner to clean the database
end
