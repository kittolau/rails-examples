# common rake task
rake db:migrate
rake db:create
rake db:seed #runs the db/seed.rb file
rake db:schema:dump

# not that common
rake db:create:all # creates the databases for all envs
rake db:drop # drops the database for the current env
rake db:drop:all # drops the databases for all envs
rake db:migrate:up # runs one specific migration
rake db:migrate:down # rolls back one specific migration
rake db:migrate:status # shows current migration status
rake db:rollback # rolls back the last migration
rake db:forward # advances the current schema version to the next one
rake db:schema:load # loads the schema into the current env's database
rake db:schema:dump # dumps the current env's schema (and seems to create the db as well)
rake db:fixtures:load # Load fixtures into the current environment's database. load specific fixtures using fixtures=x,y
rake db:schema:dump # Create a db/schema.rb file that can be portably used against any db supported by ar.
rake db:schema:load # Load a schema.rb file into the database.
rake db:sessions:clear # Clear the sessions table.
rake db:sessions:create # Creates a sessions table for use with cgi::session::activerecordstore.
rake db:structure:dump # Dump the database structure to a sql file.
rake db:test:clone # Recreate the test database from the current environment's database schema.
rake db:test:clone_structure # Recreate the test databases from the development structure.
rake db:test:prepare # Prepare the test database and load the schema.
rake db:test:purge # Empty the test database.


