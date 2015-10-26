
# common rake task
rake log:clear # Truncates all *.log files in log/ to zero bytes
rake routes
rake stats
rake assets:precompile

# uncommon rake task
rake test # Report code statistics (klocs, etc) from the application.
rake test # Test all units and functionals
rake test:functionals # Run tests for functionalsdb:test:prepare
rake test:integration # Run tests for integrationdb:test:prepare
rake test:plugins # Run tests for pluginsenvironment
rake test:recent # Run tests for recentdb:test:prepare
rake test:uncommitted # Run tests for uncommitteddb:test:prepare
rake test:units # Run tests for unitsdb:test:prepare

rake doc:appBuild the app HTML Files.
rake doc:clobber_app # Remove rdoc products.
rake doc:clobber_plugins # Remove plugin documentation.
rake doc:clobber_rails Remove rdoc products.
rake doc:plugins # Generate documation for all installed plugins.
rake doc:rails # Build the rails html files.
rake doc:reapp # Force a rebuild of the rdoc files
rake doc:rerails # Force a rebuild of the rdoc files

rake rails:freeze:edge # Lock this application to latest edge rails. lock a specific revision with revision=x.
rake rails:freeze:gems # Lock this application to the current gems (by unpacking them into vendor/rails)
rake rails:unfreeze # Unlock this application from freeze of gems or edge and return to a fluid use of system gems
rake rails:update # Update both scripts and public/javascripts from rails.
rake rails:update:javascripts # Update your javascripts from your current rails install.
rake rails:update:scripts # Add new scripts to the application script/ directory.

rake tmp:cache:clear # Clears all files and directories in tmp/cache
rake tmp:clear # Clear session, cache, and socket files from tmp/
rake tmp:create # Creates tmp directories for sessions, cache, and sockets
rake tmp:sessions:clear # Clears all files in tmp/sessions
rake tmp:sockets:clear # Clears all ruby_sess.* files in tmp/sessions
