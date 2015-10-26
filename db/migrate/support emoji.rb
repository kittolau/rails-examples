# http://blog.arkency.com/2015/05/how-to-store-emoji-in-a-rails-app-with-a-mysql-database/

#execute SQL to allow emoji to be stored in Rails and MySQL
#
#Please notice the VARCHAR(191) fragment.
# There is one important thing you should know - when switching to utf8mb4 charset,
# the maximum length of a column or index key is the same as in utf8 charset in terms of bytes.
#  This means it is smaller in terms of characters, since the maximum length of a character in utf8mb4 is four bytes,
#   instead of three in utf8. The maximum index length of InnoDB storage engine is 767 bytes, so if you are indexing your VARCHAR columns,
#    you would need to change their length to 191 instead of 255.
#

class ConvertDatabaseToUtf8mb4 < ActiveRecord::Migration
  def change
    # for each table that will store unicode execute:
    execute "ALTER TABLE table_name CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
    # for each string/text column with unicode content execute:
    execute "ALTER TABLE table_name CHANGE column_name VARCHAR(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin"
  end
end

#You should also change your database.yml and add encoding and (optionally) collation keys:

production:
  # ...
  encoding: utf8mb4
  collation: utf8mb4_bin

#Rails, why you don’t like utf8mb4?

#After changing character set,
# you may experience the Mysql2::Error: Specified key was too long;
#  max key length is 767 bytes: CREATE UNIQUE INDEX error when performing rake db:migrate task.
#   It is related to the InnoDB maximum index length described in previous section.
#    There is a fix for schema_migrations table in Rails 4+, however you still can experience this error on tables created by yourself.
#    As far as I am concerned this is still not fixed in Rails 4.2. You can resolve this issue in two ways:

#You can monkey patch ActiveRecord::ConnectionAdapters::AbstractMysqlAdapter::NATIVE_DATABASE_TYPES using the following initializer:
  #!ruby
  # config/initializers/mysql_utf8mb4_fix.rb
  require 'active_record/connection_adapters/abstract_mysql_adapter'

  module ActiveRecord
    module ConnectionAdapters
      class AbstractMysqlAdapter
        NATIVE_DATABASE_TYPES[:string] = { :name => "varchar", :limit => 191 }
      end
    end
  end

#You can also switch to DYNAMIC MySQL table format add add ROW_FORMAT=DYNAMIC to your CREATE TABLE calls when
#creating new tables in migrations (that would increase the maximum key length from 767 bytes to 3072 bytes):
  #!ruby
  create_table :table_name, options: 'ROW_FORMAT=DYNAMIC' do |t|
    # ...
  end

#You wouldn’t experience this issues when using PostgreSQL, but sometimes you just have to support legacy application that uses MySQL and migrating data to other RDBMS may not be an option.

