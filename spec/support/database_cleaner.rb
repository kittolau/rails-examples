require 'database_cleaner'

RSpec.configure do |config|

  # Deletion
  # This means the database tables are cleaned using a delete + recreate strategy.
  # In SQL this means using the DROP TABLE + CREATE TABLE statements.
  # This strategy would be considered the slowest,
  # since you have to not only delete the table data,
  # but also the whole table structure and then recreate it back.
  # However in case of problems with other methods this can be considered the safest fallback method.

  # Truncation
  # This means the database tables are cleaned using the SQL TRUNCATE TABLE command.
  # This will simply empty the table immidiately,
  # without deleting the table structure itself.

  # Transaction
  # This means using BEGIN TRANSACTION statements coupled with ROLLBACK to roll back a sequence of previous database operations.
  # Think of it as an "undo button" for databases.
  # I would think this is the most frequently used cleaning method,
  #  and probably the fastest since changes need not be directly committed to the DB.

  #before whole spec
  config.before(:suite) do
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.clean_with(:truncation)
    puts "delete db"
  end

  #before all test in a spec
  # config.before(:all) do
  #   DatabaseCleaner.strategy = :deletion
  # end

  #before each test in a spec
  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
