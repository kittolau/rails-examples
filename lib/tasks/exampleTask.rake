namespace :dev do

  #你可以輸入 rake -T 看到所有的 rake 指令。而要在 Rails 環境中撰寫 Rake，請將附檔名為 .rake 的檔案放在 lib/tasks 目錄下即可，例如：

  desc "Rebuild system"
  task :build => ["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate", :setup ]

  desc "Setup system data"
  task :setup => :environment do
      puts "Create system user"
      u = User.new( :login => "root", :password => "password", :email => "root@example.com", :name => "管理員")
      u.is_admin = true
      u.save!
  end

  #透過執行 rake dev:build，就會自動清除 log 檔案，砍掉資料庫，執行 migrate，然後執行 rake dev:setup 建立一個使用者。

  #其他常見的使用情境包括：
    # 1. 修正上線的資料，這樣部署到Production後，可以用來執行 
    # 2. 建立開發用的假資料 
    # 3. 搭配排成工具使用，例如每天凌晨三點寄出通知信、每週一產生報表等等
end