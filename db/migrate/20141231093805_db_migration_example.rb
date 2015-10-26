class DbMigrationExample < ActiveRecord::Migration
  #============migration_name ===============
  #常見的命名方式有Add欄位名To表格名或是Remove欄位名From表格名，不過這沒有一定，能描述目的即可。


  # ================Migration 可用的方法=====================
  # 在up或down方法裡，我們有以下方法可以使用：

  # 對資料表做修改:

  # create_table(name, options) 新增資料表
  # drop_table(name) 移除資料表
  # rename_table(old_name, new_name) 修改資料表名稱
  # change_table 修改資料表欄位
  # 個別修改資料表欄位:

  # add_column(table, column, type, options) 新增一個欄位
  # rename_column(table, old_column_name, new_column_name) 修改欄位名稱
  # change_column(table, column, type, options) 修改欄位的型態(type)
  # remove_column(table , column) 移除欄位
  # 新增、移除索引:

  # add_index(table, columns, options) 新增索引
  # remove_index(table, index) 移除索引
  # 記得將所有外部鍵 foreign key 加上索引


  #===================timestamps=========================
  #其中的 timestamps 會建立叫做 created_at 和 updated_at 的時間欄位，這是Rails的常用慣例。它會自動設成資料新增的時間以及會後更新時間。


  #==================up&down VS change===================
  #這裡怎麼不是用up和down方法？Rails 3.1 版新增了change方法可以很聰明的自動處理大部分down的情況，上述情況的down就是移除catrgories資料表和移除events的category_id欄位，因此就不需要分別寫up和down了。如果Rails無法判斷，會在跑rake db:migrate時提醒你不能用change，需要分開寫up和down。


  #==================data type========================
  # 資料庫的欄位定義

  # 為了能夠讓不同資料庫通用，以下是Migration中的資料型態與實際資料庫使用的型態對照：

  # Rails中的型態 說明  MySQL Postgres  SQLite3
  # :string 有限長度字串  varchar(255)  character varying(255)  varchar(255)
  # :text 不限長度文字  text  text  text
  # :integer  整數  int(4)  integer integer
  # :float  浮點數 float float float
  # :decimal  十進位數  decimal decimal decimal
  # :datetime 日期時間  datetime  timestamp datetime
  # :timestamp  時間戳章  datetime  timestamp datetime
  # :time 時間  time  time  datetime
  # :date 日期  date  date  date
  # :binary 二進位 blob  bytea blob
  # :boolean  布林值 tinyint boolean boolean
  # :references 用來參照到其他Table的外部鍵  int(4)  integer integer
  # 另外，欄位也還有一些參數可以設定：

  # :null 是否允許NULL，預設是允許
  # :default 預設值
  # :limit 用於string、text、integer、binary指定最大值
  # 例如：

  # create_table :events do |t|
  #     t.string :name, :null => false, :limit => 60, :default => "N/A"
  #     t.references :category # 等同於 t.integer :category_id
  # end
  # 參考資料：ActiveRecord::ConnectionAdapters::TableDefinition


  #=====================naming convertion====================
  # 欄位名稱慣例

  # 我們已經介紹過了 timestamps 方法會自動新增兩個時間欄位，Rails 還保留了幾個名稱作為慣例之用：

  # 欄位名稱  用途
  # id  預設的主鍵欄位名稱
  # {tablename}_id  預設的外部鍵欄位名稱
  # created_at  如果有這個欄位，Rails便會在新增時設定時間
  # updated_at  如果有這個欄位，Rails便會在修改時設定時間
  # created_on  如果有這個欄位，Rails便會在新增時設定時間
  # updated_on  如果有這個欄位，Rails便會在修改時設定時間
  # {tablename}_count 如果有使用 Counter Cache 功能，這是預設的欄位名稱
  # type  如果有這個欄位，Rails便會啟動STI功能(詳見ActiveRecord章節)
  # lock_version  如果有這個欄位，Rails便會啟動Optimistic Locking功能(詳見ActiveRecord章節)


  #========================rake db task======================
  # Migration 搭配的 Rake 任務

  # rake db:create 依照目前的 RAILS_ENV 環境建立資料庫
  # rake db:create:all 建立所有環境的資料庫
  # rake db:drop 依照目前的 RAILS_ENV 環境刪除資料庫
  # rake db:drop:all 刪除所有環境的資料庫
  # rake db:migrate 執行Migration動作
  # rake db:rollback STEP=n 回復上N個 Migration 動作
  # rake db:migrate:up VERSION=20080906120000 執行特定版本的Migration
  # rake db:migrate:down VERSION=20080906120000 回復特定版本的Migration
  # rake db:version 目前資料庫的Migration版本
  # rake db:seed 執行 db/seeds.rb 載入種子資料
        # 種子資料Seed的意思是，有一些資料是應用程式跑起來必要基本資料，而這些資料的產生我們會放在db/seeds.rb這個檔案。例如，讓我們打開來，加入一些基本的Category資料：

        # # This file should contain all the record creation needed to seed the database with its default values.
        # # The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
        # #
        # # Examples:
        # #
        # #   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
        # #   Mayor.create(name: 'Emanuel', city: cities.first)

        # Category.create!( :name => "Science" )
        # Category.create!( :name => "Art" )
        # Category.create!( :name => "Education" )
        # 輸入rake db:seed就會執行這個檔案了。通常執行的時機是第一次建立好資料庫和跑完Migration之後。
  # 如果需要指定Rails環境，例如production，可以輸入 RAILS_ENV=production rake db:migrate


  #=========================data migration=========================
  # 資料 Migration

  # Migrations 不只可以用來變更資料表定義，它也很常用來遷移資料。新增或修改欄位時，還蠻常也需要根據現有的資料，來設定新欄位的值。這時候我們就會在 Migration 利用 ActiveRecord 來操作資料。

  # 不過，如果你在Migration中修改了資料表欄位，隨即又使用這個Model來做資料更新，那麼因為Rails會快取資料表的欄位定義，所以會無法讀到剛剛修改的資料表。這時候有幾個辦法可以處理：

  # 第一是呼叫 reset_column_information 重新讀取資料表定義。

  # 第二是在 Migration 中用 ActiveReocrd::Base 定義一個新的空白 Model 來暫時使用。

  # 第三是用 execute 功能來執行任意的 SQL。


  #=========================migration on Production====================
  # Production上跑Migration注意事項

  # 當有上萬筆資料的時候，如果有修改資料庫表格ALTER TABLE的話，他會Lock table無法寫入，可能會跑好幾個小時很難事前預估。建議用staging server用接近production的資料來先測試會跑多久。

  # http://www.engineyard.com/blog/2011/making-migrations-faster-and-safer/
  # http://backstage.soundcloud.com/2011/05/introducing-the-large-hadron-migrator-3/
  # bulk參數

  # :bulk => true可以讓變更資料庫欄位的Migration更有效率的執行，如果沒有加這個參數，或是直接使用add_column、rename_column、remove_column等方法，那麼Rails會拆開SQL來執行，例如：

  # change_table(:users) do |t|
  #   t.string :company_name
  #   t.change :birthdate, :datetime
  # end
  # 會產生：

  # ALTER TABLE `users` ADD `im_handle` varchar(255)
  # ALTER TABLE `users` ADD `company_id` int(11)
  # ALTER TABLE `users` CHANGE `updated_at` `updated_at` datetime DEFAULT NULL
  # 加上:bulk => true之後：

  # change_table(:users, :bulk => true) do |t|
  #   t.string :company_name
  #   t.change :birthdate, :datetime
  # end
  # 會合併產生一行SQL：

  # ALTER TABLE `users` ADD COLUMN `im_handle` varchar(255), ADD COLUMN `company_id` int(11), CHANGE `updated_at` `updated_at` datetime DEFAULT NULL
  # 這對已有不少資料量的資料庫來說，會有不少執行速度上的差異，可以減少資料庫因為修改被Lock鎖定的時間。


  def up
  end

  def down
  end

  def change
  end
end



