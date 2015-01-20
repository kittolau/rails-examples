class ActiveRecordExampleController < ApplicationController
  def model

    #=============================authorized query=========================
    # 不受限的資訊查詢

    # 當你需要根據使用者傳進來的params[:id]做資料查詢的時候，你需要注意查詢的範圍，例如以下是找訂單：

    #   def show
    #     @order = Order.find(params[:id])
    #   end
    # 使用者只要隨意變更params[:id]，就可以查到別人的訂單，你可能會寫出以下的程式來防範：

    # def show
    #   @order = Order.find(params[:id])
    #   if @order.user_id != current_user.id
    #     render :text => "你沒有權限"
    #     return
    #   end
    # end
    # 不過這是多餘的寫法，你其實只要透過ActiveRecord限定範圍即可：

    #   def show
    #     @order = current_user.orders.find(params[:id])
    #   end
    # 這樣如果沒權限，就會變成找不到資料而已。


    #==============================SQL Inject===================================
    # SQL injection注入攻擊

    # SQL injection注入是說攻擊者可以輸入任意的SQL讓網站執行，這可說是最有殺傷力的攻擊。如果你寫出以下這種直接把輸入放在SQL條件中的程式：

    # Project.where("name = '#{params[:name]}'")
    # 那麼使用者只要輸入：

    # x'; DROP TABLE users; --
    # 最後執行的SQL就會變成

    # SELECT * FROM projects WHERE name = 'x'; DROP TABLE users; --’
    # 其中的;結束了第一句，第二句DROP TABLE users;就讓你欲哭無淚。

    # Exploits of a Momhttp://xkcd.com/327/
    # 要處理這個問題，也是一樣要對任何有包括使用者輸入值的SQL語句做逸出。在Rails ActiveRecord的where方法中使用Hash或Array寫法就會幫你處理，所以請一定都用這種寫法，而不要使用上述的字串參數寫法：

    # Project.where( { :name => params[:name] } )
    # # or
    # Project.where( ["name = ?", params[:name] ] )
    # 如果你有用到以下的方法，ActiveRecord是不會自動幫你逸出，要特別注意：

    # find_by_sql
    # execute
    # where 用字串參數
    # group
    # order
    # 你可以自定一些固定的參數，並檢查使用者輸入的資料，例如：

    # class User < ActiveRecord::Base
    #   def self.find_live_by_order(order)
    #     raise "SQL Injection Warning" unless ["id","id desc"].include?(order)
    #     where( :status => "live" ).order(order)
    #   end
    # end
    # 或是手動呼叫ActiveRecord::Base::connection.quote方法：

    # class User < ActiveRecord::Base
    #   def self.find_live_by_order(order)
    #     where( :status => "live" ).order( connection.quote(order) )
    #   end
    # end

    #===============================change layout=================================
    # 如果需要指定Controller的Layout，可以這麼做：

    # class EventsController < ApplicationController
    #    layout "special"
    # end
    # 這樣就會指定Events Controller下的Views都使用app/views/layouts/special.html.erb這個Layout，你可以加上參數:only或:except表示只有特定的Action：

    # class EventsController < ApplicationController
    #    layout "special", :only => :index
    # end
    # 或是

    # class EventsController < ApplicationController
    #    layout "special", :except => [:show, :edit, :new]
    # end
    # 請注意到使用字串和Symbol是不同的。使用Symbol的話，它會透過一個同名的方法來動態決定，例如以下的Layout是透過determine_layout這個方法來決定：

    # class EventsController < ApplicationController
    #    layout :determine_layout

    #     private

    #     def determine_layout
    #        ( rand(100)%2 == 0 )? "event_open" : "event_closed"
    #     end
    # end
    # 除了在Controller層級設定Layout，我們也可以設定個別的Action使用不同的Layout，例如:

    # def show
    #    @event = Event.find(params[:id])
    #     render :layout => "foobar"
    # end
    # 這樣show Action的樣板就會套用foobar Layout。更常見的情形是關掉Layout，這時候我們可以寫render :layout => false。


    #================Has many Relational Active Record Mehtod=================
    # 在關聯的集合上，我們有以下方法可以使用：

    # «(*records) and create
    # any? and empty?
    # build and new
    # count
    # delete_all
    # destroy_all
    # find(id)
    # ids
    # include?(record)
    # first, last
    # reload
    # 例如：

    # > e = Event.first
    # > e.attendees.destroy_all


   


    # ====================新增============================

    # ActiveRecord提供了四種API，分別是save、save!、create和create!：

    # > a = Category.new( :name => 'Ruby', :position => 1 )
    # > a.save

    # > b = Category.new( :name => 'Perl', :position => 2 )
    # > b.save!

    # > Category.create( :name => 'Python', :position => 3 )
    # > c = Category.create!( :name => 'PHP', :position => 4 )
    # 其中create和create!就等於new完就save和save!，有無驚嘆號的差別在於validate資料驗證不正確的動作，無驚嘆號版本會回傳布林值(true或false)，有驚嘆號版本則是驗證錯誤會丟出例外。

    # 何時使用驚嘆號版本呢？save和create通常用在會處理回傳布林值(true/false)的情況下(例如在 controller 裡面根據成功失敗決定 render 或 redirect)，否則在預期應該會儲存成功的情況下，請用 save!或create! 來處理，這樣一旦碰到儲存失敗的情形，才好追蹤 bug。

    # 透過:validate => false參數可以略過驗證

    # > c.save( :validate => false )
    # new_record?

    # 這個方法可以知道物件是否已經存在於資料庫：

    # > c.new_record?
    # => false
    # > c.persisted?
    # => true

    #================join and include=======================
    # joins 和 includes 查詢

    # 針對Model中的belongs_to和has_many關連，可以使用joins，也就是INNER JOIN

    # Event.joins(:category)
    # # SELECT "events".* FROM "events" INNER JOIN "categories" ON "categories"."id" = "events"."category_id"
    # 可以一次關連多個：

    #  Event.joins(:category, :location)
    # joins主要的用途是來搭配where的條件查詢：

    # Event.joins(:category).where("categories.name is NOT NULL")
    # # SELECT "events".* FROM "events" INNER JOIN "categories" ON "categories"."id" = "events"."category_id" WHERE (categories.name is NOT NULL)
    # 透過joins抓出來的event物件是沒有包括其關連物件的。如果需要其關連物件的資料，會使用includes。includes可以預先將關連物件的資料也讀取出來，避免N+1問題(見效能一章)

    # Event.includes(:category)
    # # SELECT * FROM events
    # # SELECT * FROM categories WHERE categories.id IN (1,2,3...)
    # 同理，也可以一次載入多個關連：

    # Event.includes(:category, :attendees)
    # # SELECT "events".* FROM "events"
    # # SELECT "categories".* FROM "categories" WHERE "categories"."id" IN (1,2,3...)
    # # SELECT "attendees".* FROM "attendees" WHERE "attendees"."event_id" IN (4, 5, 6, 7, 8...)
    # includes方法也可以加上條件：

    # Event.includes(:category).where( :category => { :position => 1 } )


    #=====================polymorphic association=====================
    # 多型關聯(Polymorphic Associations)

    # 多型關連(Polymorphic Associations)可以讓一個 Model 不一定關連到某一個特定的 Model，秘訣在於除了整數的_id外部鍵之外，再加一個字串的_type欄位說明是哪一種Model。

    # 例如一個Comment model，我們可以透過多型關連讓它belongs_to到各種不同的 Model上，假設我們已經有了Article與Photo這兩個Model，然後我們希望這兩個Model都可以被留言。不用多型關連的話，你得分別建立ArticleComment和PhotoComment的model。用多型關連的話，無論有多少種需要被留言的Model，只需要一個Comment model即可：

    # rails g model comment content:text commentable_id:integer commentable_type
    # 這樣會產生下面的 Migration 檔案：

    # class CreateComments < ActiveRecord::Migration
    #   def change
    #     create_table :comments do |t|
    #       t.text :content
    #       t.integer :commentable_id
    #       t.string :commentable_type

    #       t.timestamps
    #     end
    #   end
    # end
    # 這個Migration檔案中，我們用content這個欄位來儲存留言的內容，commentable_id用來儲存被留言的物件的id而commentable_type則用來儲存被留言物件的種類，以這個例子來說被留言的對象就是Article與Photo這兩種Model，這個Migration檔案也可以改寫成下面這樣：

    # class CreateComments < ActiveRecord::Migration
    #   def change
    #     create_table :comments do |t|
    #       t.text :content
    #       t.belongs_to :commentable, :polymorphic => true

    #       t.timestamps
    #     end
    #   end
    # end
    # 回到我們的Model，我們必須指定他們的關聯關係：

    # class Comment < ActiveRecord::Base
    #   belongs_to :commentable, :polymorphic => true
    # end

    # class Article < ActiveRecord::Base
    #   has_many :comments, :as => :commentable
    # end

    # class Photo < ActiveRecord::Base
    #   has_many :comments, :as => :commentable
    # end
    # 這樣會告訴Rails如何去設定你的多型關係，現在讓我們進console實驗看看：

    # article = Article.first

    # # 透過關連新增留言
    # comment = article.comments.create(:content => "First Comment")

    # # 你可以發現 Rails 很聰明的幫我們指定了被留言物件的種類和id
    # comment.commentable_type => "Article"
    # comment.commentable_id => 1

    # # 也可以透過 commentable 反向回查關連的物件
    # comment.commentable => #<Article id: 1, ....>
    # DBA背景的同學可能會注意到PolymorphicAassociations無法做到保證Referential integrity特性。原因很簡單，既然不知道_id會指到哪個table，自然也就沒辦法在資料庫層級加上Foreign key constraint。


    #========================QUERY==========================
    # 如何查詢

    # ActiveRecord 使用了 Arel 技術來實作查詢功能，你可以自由組合 where、limit、select、order 等條件。

    # Arel 是 relational algebra” library。但根據 2.0 實作者 tenderlove 的說法，也可以說是一種 SQL compiler。 http://engineering.attinteractive.com/2010/12/architecture-of-arel-2-0/
    # first, last 和 all

    # 這三個方法可以分別拿出資料庫中的第一筆、最後一筆及全部的資料：

    # c1 = Category.first
    # c2 = Category.last
    # categories = Category.all # 這會是一個陣列
    # 如果資料量較多，請不要在正式上線環境中執行.all 把所有資料拿出來，這樣會耗費非常多的記憶體。請用分頁或縮小查詢範圍。
    # find

    # 已知資料的主鍵 ID 的值的話，可以使用 find 方法：

    # c3 = Category.find(1)
    # c4 = Category.find(2)
    # find 也可以接受陣列參數，這樣就會一次找尋多個並回傳陣列：

    # arr = Category.find([1,2])
    # # 或是
    # arr = Category.find(1,2)
    # 如果找不到資料的話，會丟 ActiveRecord::RecordNotFound 例外。如果是 find_by_id 就不會丟出例外，而是回傳 nil。
    # reload

    # 這個方法可以將物件從資料庫裡重新載入一次：

    # > e = Event.first
    # > e.name = "test"
    # > e.reload
    # pluck

    # 這個方法可以非常快速的撈出指定欄位的資料：

    # Event.pluck(:name)
    # => ["foo", "bar"]
    # Category.pluck(:id, :name)
    # => [ [1, "Tech"], [2, "Business"] ]
    # find_by_sql

    # 如果需要手動撰寫 SQL，可以使用find_by_sql和count_by_sql，例如：

    # c8 = Category.find_by_sql("select * from categories")
    # 不過需要用到的機會應該很少。

    # where 查詢條件

    # where 可以非常彈性的組合出 SQL 查詢，例如：

    # c9 = Category.where( :name => 'Ruby', :position => 1 )
    # c10 = Category.where( [ "name = ? or position = ?", 'Ruby', 2] )
    # 其中參數有兩種寫法，一種是 Hash，另一種是 Array。前者的寫法雖然比較簡潔，但是就沒辦法寫出 or 的查詢。注意到不要使用字串寫法，例如

    # Category.where("name = #{params[:name]}") # 請不要這樣寫
    # 這是因為字串寫法會有 SQL injection 的安全性問題，請改用陣列寫法。

    # limit

    # limit 可以限制筆數

    # c = Category.limit(5).all
    # c.size # 5
    # order

    # order 可以設定排序條件

    # Category.order("position")
    # Category.order("position DESC")
    # Category.order("position DESC, name ASC")
    # 如果要消去order條件，可以用reorder：

    # Category.order("position").reorder("name") # 改用 name 排序
    # Category.order("position").reorder(nil) # 取消所有排序
    # offset

    # offset 可以設定忽略前幾筆不取出，通常用於資料分頁：

    # c = Category.limit(2)
    # c.first.id # 1
    # c = Category.limit(2).offset(3)
    # c.first.id # 4
    # select

    # 預設的 SQL 查詢會取出資料的所有欄位，有時候你可能不需要所有資料，為了效能我們可以只取出其中特定欄位：

    # Category.select("id, name")
    # 例如欄位中有 Binary 資料時，你不會希望每次都讀取出龐大的 Binary 資料佔用記憶體，而只希望在使用者要下載的時候才讀取出來。
    # readonly

    # c = Category.readonly.first
    # 如此查詢出來的c就無法修改或刪除，不然會丟出ActiveRecord::ReadOnlyRecord例外。

    # group 和 having

    # group運用了資料庫的group_by功能，讓我們可以將計算後的結果依照某一個欄位分組後回傳，例如說今天我有一批訂單，裡面有分店的銷售金額，我希望能這些金額全部加總起來變成的各分店銷售總金額，這時候我就可以這麼做：

    # Order.select("store_name, sum(sales)").group("store")
    # 這樣會執行類似這樣的SQL:

    # SELECT store_name, sum(sales) FROM orders GROUP BY store_name
    # having則是讓group可以再增加條件，例如我們想為上面的查詢增加條件是找出業績銷售超過10000的分店，那麼我可以這麼下：

    # Order.select("store_name, sum(sales)").group("store").having("sum(sales) > ?", 10000)
    # 所執行的SQL便會是:

    # SELECT store_name, sum(sales) FROM orders GROUP BY store_name HAVING sum(sales) > 10000
    # 串接寫法

    # 以上的 where, order , limit, offset, joins, select 等等，都可以自由串接起來組合出最終的 SQL 條件：

    # c12 = Category.where( :name => 'Ruby' ).order("id desc").limit(3)
    # find_each 批次處理

    # 如果資料量很大，但是又需要全部拿出來處理，可以使用 find_each 批次處理

    # Category.where("position > 1").find_each do |category|
    #     category.do_some_thing
    # end
    # 預設會批次撈 1000 筆，如果需要設定可以加上 :batch_size 參數。

    # 重新載入

    # 如果已經讀取的 AR 資料，需要重新載入，可以用 reload 方法：

    # p = Category.first
    # p.reload

    #========================= UPDATE===================================
    # 更新

    # 更新一個ActiveRecord物件：

    # c13 = Category.first
    # c13.update(attributes)
    # c13.update!(attributes)
    # c13.update_column(attribute_name, value)
    # c13.update_columns(attributes)
    # 注意 update_column 會略過 validation 資料驗證 注意 mass assign 安全性問題，詳見安全性一章。
    # 我們也可以用update_all(updates, conditions=nil, options={})來一次更新資料庫的多筆資料：

    # > Category.update_all( { :name => "New Name" }, "position > 1" )
    # increment 和 decrement

    # 數字欄位可以使用increment和decrement方法，也有increment!和decrement!立即存進資料庫的用法。

    # toggle

    # Boolean欄位可以使用toggle方法，同樣也有toggle!

    #=========================DELETE =================================
    # 一種是先抓到該物件，然後刪除：

    # c12 = Category.first
    # c12.destroy
    # 另一種是直接對類別呼叫刪除，傳入 ID 或條件：

    # Category.delete(2)
    # Category.delete([2,3,4])
    # Category.delete_all(conditions = nil)
    # Category.destroy_all(conditions = nil)
    # delete 不會有 callback 回呼，destroy 有 callback 回呼。什麼是回呼詳見下一章。

    #====================STAT=====================================
    # 統計方法

    # Category.count
    # Category.average(:position)
    # Category.maximum(:position)
    # Category.minimum(:position)
    # Category.sum(:position)
    # 其中我們可以利用上述的 where 條件縮小範圍，例如：

    # Category.where( :name => "Ruby").count

    #=====================SCopes================================
    # Scopes 作用域

    # Model Scopes是一項非常酷的功能，它可以將常用的查詢條件宣告起來，讓程式變得乾淨易讀，更厲害的是可以串接使用。例如，我們編輯app/models/event.rb，加上兩個Scopes：

    # class Event < ActiveRecord::Base
    #     scope :open_public, -> { where( :is_public => true ) }
    #     scope :recent_three_days, -> { where(["created_at > ? ", Time.now - 3.days ]) }
    # end

    # > Event.create( :name => "public event", :is_public => true )
    # > Event.create( :name => "private event", :is_public => false )
    # > Event.create( :name => "private event", :is_public => true )

    # > Event.open_public
    # > Event.open_public.recent_three_days
    # -> {...}是Ruby語法，等同於Proc.new{...}或lambda{...}，用來建立一個匿名方法物件
    # 串接的順序沒有影響的，都會一併套用。我們也可以串接在has_many關聯後：

    # > user.events.open_public.recent_three_days
    # 接著，我們可以設定一個預設的Scope，通常會拿來設定排序：

    # class Event < ActiveRecord::Base
    #     default_scope -> { order('id DESC') }
    # end
    # unscoped方法可以暫時取消預設的default_scope：

    # Event.unscoped do
    #     Event.all
    #     # SELECT * FROM events
    # end
    # 最後，Scope也可以接受參數，例如：

    # class Event < ActiveRecord::Base
    #     scope :recent, -> { |date| where(["created_at > ? ", date ]) }

    #     # 等同於 scope :recent, lambda{ |date| where(["created_at > ? ", date ]) }
    #     # 或 scope :recent, Proc.new{ |t| where(["created_at > ? ", t ]) }
    # end

    # Event.recent( Time.now - 7.days )
    # 不過，筆者會推薦上述這種帶有參數的Scope，改成如下的類別方法，可以比較明確看清楚參數是什麼，特別是你想給預設值的時候：

    # class Event < ActiveRecord::Base
    #     def self.recent(t=Time.now)
    #         where(["created_at > ? ", t ])
    #     end
    # end

    # Event.recent( Time.now - 7.days )
    # 這樣的效果是一樣的，也是一樣可以和其他Scope做串接。

    # all方法可以將Model轉成可以串接的形式，方便依照參數組合出不同查詢，例如

    # fruits = Fruit.all
    # fruits = fruits.where(:colour => 'red') if options[:red_only]
    # fruits = fruits.limit(10) if limited?
    # 可以呼叫to_sql方法觀察實際ORM轉出來的SQL，例如Event.open_public.recent_three_days.to_sql

    #===============Virtual Attribute=============================
    # 虛擬屬性(Virtual Attribute)

    # 有時候表單裡操作的屬性資料，不一定和資料庫的欄位完全對應。例如資料表分成first_name和last_name兩個欄位好了，但是表單輸入和顯示的時候，只需要一個屬性叫做full_name，這時候你就可以在model裡面定義這樣的方法：

    # def full_name
    #     "#{self.first_name} #{self.last_name}"
    # end

    # def full_name=(value)
    #     self.first_name, self.last_name = value.to_s.split(" ", 2)
    # end

    #================transaction================================
    # 交易Transactions

    # Transaction(交易)保證所有資料的操作都只有在成功的情況下才會寫入到資料庫，最著名的例子也就是銀行的帳戶交易，只有在帳戶提領金額及存入帳戶這兩個動作都成功的情況下才會將這筆操作寫入資料庫，否則在其中一個動作因為某些原因失敗的話就會放棄所有已做的操作將資料回復到交易前的狀態。在Rails中使用交易的方式像這樣：

    # ActiveRecord::Base.transaction do
    #   david.withdrawal(100)
    #   mary.deposit(100)
    # end
    # 你可以在一個交易中包含不同Active Record的類別或物件，這是因為交易是以資料庫連線為範圍，而不是個別Model：

    # User.transaction do
    #   User.create!(:name => 'ihower')
    #   Feed.create!
    # end
    # 注意到這裡我們要使用create!而不是create，這是因為前者驗證失敗才會丟出例外，好讓整個交易失敗。同理，在交易裡做更新應該使用update!而不是update。

    # 單一Model的save及destroy方法已經幫你使用transaction包起來了，當資料驗證失敗或其中的回呼發生例外時，Rails就會觸發rollback。所以下述的交易區塊是多餘的不需要寫：

    # User.transaction do # 這是多餘的
    #   User.create!(:name => 'ihower')
    # end
    # 另外，由於資料的更新要在交易完成後才能被讀取到，所以如果你在after_save回呼裡讓外部服務存取(例如呼叫全文搜尋引擎做索引)，很可能因為交易尚未完成，會讀取不到更新。這時候必須改用after_commit這個回呼，才能確保讀取到交易完成後的資料。

    #=====================dirty objects==============================
    # Dirty objects

    # Dirty Objects功能可以追蹤Model的屬性是否有改變：

    # person = Person.find_by_name('Uncle Bob')
    # person.changed?       # => false 沒有改變任何值

    # # 讓我們來改一些值
    # person.name = 'Bob'
    # person.changed?       # => true 有改變
    # person.name_changed?  # => true 這個屬性有改變
    # person.name_was       # => 'Uncle Bob' 改變之前的值
    # person.name_change    # => ['Uncle Bob', 'Bob']
    # person.name = 'Bill'
    # person.name_change    # => ['Uncle Bob', 'Bill']

    # # 儲存進資料庫
    # person.save
    # person.changed?       # => false
    # person.name_changed?  # => false

    # # 看看哪些屬性改變了
    # person.name = 'Bob'
    # person.changed        # => ['name']
    # person.changes        # => { 'name' => ['Bill', 'Bob'] }
    # 注意到Model資料一旦儲存進資料庫，追蹤記錄就重算消失了。
    # 什麼時候會用到這個功能呢？通常是在儲存進資料庫前的回呼、驗證或Observer中，你想根據修改了什麼來做些動作，這時候Dirty Objects功能就派上用場了。


    #=======================serialize===========================
    # 序列化Serialize

    # 序列化(Serialize)通常指的是將一個物件轉換成一個可被資料庫儲存及傳輸的純文字形態，反之將這筆資料從資料庫讀出後轉回物件的動作我們就稱之為反序列(Deserialize)，Rails提供了serialize讓你指定需要序列化資料的欄位，任何物件在存入資料庫時就會自動序列化成YAML格式，而當從資料庫取出時就會自動幫你反序列成原先的物件。這個欄位通常用text型態，有比較大的空間可以儲存資料，然後將一個Hash物件序列化之後存進去。

    # 常用的情境例如雜七雜八的使用者settings：

    # class User < ActiveRecord::Base
    #   serialize :settings
    # end

    # > user = User.create(:settings => { "sex" => "male", "url" => "foo" })
    # > User.find(user.id).settings # => { "sex" => "male", "url" => "foo" }
    # 或是一些不需要資料庫索引和正規化的一整包資料，例如KML軌跡資料等等。

    # 雖然序列化很方便可以讓你儲存任意的物件，但是缺點是序列化資料就失去了透過資料庫查詢索引的功效，你無法在SQL的where條件中指定序列化後的資料。


    #======================Store==================================
    # Store

    # Store又在包裹了上一節的序列化功能，是個簡單又實用的功能，讓你可以將某個欄位指定儲存為Hash值。舉例來說，上一節的settings也可以改用store來設定：

    # class User < ActiveRecord::Base
    #   store :settings, :accessors => [:sex, :url]
    # end
    # 特別的是其中accessors用來設定可以直接存取的屬性，這樣就可以像平常一樣那樣操作sex和url這兩個屬性，讓我們進console實驗看看:

    # > user = User.new(:sex => "male", :url => "http://example.com")
    # > user.sex
    #  => "male"
    # > user.url
    #  => "http://example.com"
    # > user.settings
    #  => {:sex => "male", :url => "http://example.com"}
    # 因為store就像使用hash一樣，你也可以直接操作它，加入新的資料：

    # > user.settings[:food] = "pizza"
    # > user.settings
    #  => {:sex => "male", :url => "http://example.com", :food => "pizza"}

    #======================Observer===============================
    # 觀察者Observers

    # Observer(觀察者)是一種常見的設計模式，可以讓你可以針對Model 的生命週期中的某些階段做出對應的行為，例如你想在使用者註冊完帳號的時寄送一封確認信給他，這時候你就可以註冊一個觀察者來觀察User Model，當User建立成功的時候便寄送Email。

    # 需要安裝rails-observers來啟用這個功能，然後使用generator來建立Observer：

    # $ rails generate observer user
    #     invoke  active_record
    #     create    app/models/user_observer.rb
    #     invoke    rspec
    #     create      spec/models/user_observer_spec.rb
    # 建立好後需要在config/application.rb中註冊這個觀察者：

    # config.active_record.observers = :user_observer
    # 在所建立的觀察者類別中，撰寫需要觸發的行為，例如：

    # class PageObserver < ActiveRecord::Observer
    #   observe :user

    #   def after_save(user)
    #     UserMailer.registration_confirmation(user).deliver # 寄送註冊確認信給 user
    #   end
    # end
    # 一個Observer中也可同時觀察多個不同的Model:

    # class ContentObserver < ActiveRecord::Observer
    #     observe :article, :comment

    #     def update_update(record)
    #       # do something
    #     end
    # end
    # Observer支援的觸發條件，和Callback所定義的七種觸發條件是相同的，詳見ActiveRecord 資料驗證及回呼 中的回呼一節

    # 與Callback不同的地方是，Observer通常是設計來做所觀察的Model以外的行為，例如在我們的例子中我們觀察了User，而在觸發的行為我們呼叫了其他類別的方法(UserMailer)，這不屬於User Model的責任範圍，因此在應用上我們會將自己Model責任範圍內的行為使用Callback，像是資料驗證或是更新。本身責任範圍外的行為則使用Observer，像是寄送Email或是呼叫背景處理等。
  

  end
end
