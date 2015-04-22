class ActiveRecordExampleController < ActionController::Base
  def index
    #create
      a = Category.new( :name => 'Ruby', :position => 1 )
      a.save
      b = Category.new( :name => 'Perl', :position => 2 )
      b.save
      #OR
      Category.create( :name => 'Python', :position => 3 )
      c = Category.create!( :name => 'PHP', :position => 4 )

    #save
      #有無驚嘆號的差別在於validate資料驗證不正確的動作
      a.save #無驚嘆號版本會回傳布林值(true或false)
      b.save! #有驚嘆號版本則是驗證錯誤會丟出例外
      #透過:validate => false參數可以略過驗證
      c.save( :validate => false )

    #update
      #注意 update_column 會略過 validation 資料驗證 注意 mass assign 安全性問題，詳見安全性一章。
      c13 = Category.first
      c13.update(attributes)
      c13.update!(attributes)
      c13.update_column(attribute_name, value)
      c13.update_columns(attributes)

      #我們也可以用update_all(updates, conditions=nil, options={})來一次更新資料庫的多筆資料：
      Category.update_all( { :name => "New Name" }, "position > 1" )

      #數字欄位可以使用increment和decrement方法，也有increment!和decrement!立即存進資料庫的用法。
      c13.visit_count.increment
      c13.visit_count.decrement

      #Boolean欄位可以使用toggle方法，同樣也有toggle!
      c13.is_admin.toggle

    #delete
      @variable.destroy #callback on deleted object
      @variable.delete #just call detete in SQL

    #query
      #first, last, all
          c1 = Category.first
          c2 = Category.last
          #如果資料量較多，請不要在正式上線環境中執行.all 把所有資料拿出來，
          #這樣會耗費非常多的記憶體。請用分頁或縮小查詢範圍。
          categories = Category.all # 這會是一個陣列

        #find
          #已知資料的主鍵 ID 的值的話，可以使用 find 方法：
          c3 = Category.find(1)
          c4 = Category.find(2)

    #scope
        #chainable empty scope
          Category.scoped
          #rails 4
          Category.none
      #condition
        #where
          #where 可以非常彈性的組合出 SQL 查詢，例如：
          c9 = Category.where( :name => 'Ruby', :position => 1 )
          c10 = Category.where( [ "name = ? or position = ?", 'Ruby', 2] )
          #using String
            Client.where("orders_count = '2'")
            # SELECT * from clients where orders_count = '2';
            # 注意到不要使用字串寫法，例如
            Category.where("name = #{params[:name]}") # 請不要這樣寫
            #  #這是因為字串寫法會有 SQL injection 的安全性問題，請改用陣列寫法。
          #using Array
            User.where(["name = ? and email = ?", "Joe", "joe@example.com"])
            # SELECT * FROM users WHERE name = 'Joe' AND email = 'joe@example.com';
            User.where(["name = :name and email = :email", { name: "Joe", email: "joe@example.com" }])
            # SELECT * FROM users WHERE name = 'Joe' AND email = 'joe@example.com';
          #using hash
            #雖然比較簡潔，但是就沒辦法寫出 or 的查詢。
            User.where({ name: "Joe", email: "joe@example.com" })
            # SELECT * FROM users WHERE name = 'Joe' AND email = 'joe@example.com'
            User.where({ name: ["Alice", "Bob"]})
            # SELECT * FROM users WHERE name IN ('Alice', 'Bob')
            User.where({ created_at: (Time.now.midnight - 1.day)..Time.now.midnight })
            # SELECT * FROM users WHERE (created_at BETWEEN '2012-06-09 07:00:00.000000' AND '2012-06-10 07:00:00.000000')

            #In the case of a belongs_to relationship, an association key can be used to specify the model if an ActiveRecord object is used as the value.
            author = Author.find(1)
            # The following queries will be equivalent:
            Post.where(author: author)
            Post.where(author_id: author)


      #field
        #pluck
          # Return Array
          #這個方法可以非常快速的撈出指定欄位的資料：
          Person.pluck(:id)
          # SELECT people.id FROM people
          # => [1, 2, 3]
          Person.pluck(:id, :name)
          # SELECT people.id, people.name FROM people
          # => [[1, 'David'], [2, 'Jeremy'], [3, 'Jose']]
          Person.pluck('DISTINCT role')
          # SELECT DISTINCT role FROM people
          # => ['admin', 'member', 'guest']

        #select
          #return Object
          #例如欄位中有 Binary 資料時，你不會希望每次都讀取出龐大的 Binary 資料佔用記憶體，而只希望在使用者要下載的時候才讀取出來。
          #預設的 SQL 查詢會取出資料的所有欄位，有時候你可能不需要所有資料，為了效能我們可以只取出其中特定欄位：
          Category.select("id, name")
        #distinct
          User.select(:name)
          # => Might return two records with the same name

          User.select(:name).distinct
          # => Returns 1 record per distinct name

          User.select(:name).distinct.distinct(false)
          # => You can also remove the uniqueness

      #paging
        #limit
          #limit 可以限制筆數
          c = Category.limit(5).all
          c.size # 5
          # order 可以設定排序條件
          Category.order("position")
          Category.order("position DESC")
          Category.order("position DESC, name ASC")
          #如果要消去order條件，可以用reorder：
          Category.order("position").reorder("name") # 改用 name 排序
          Category.order("position").reorder(nil) # 取消所有排序

        #offset
          #offset 可以設定忽略前幾筆不取出，通常用於資料分頁：
          c = Category.limit(2)
          c.first.id # 1
          c = Category.limit(2).offset(3)
          c.first.id # 4

      #agregation
        Order.select("store_name, sum(sales)").group("store").having("sum(sales) > ?", 10000)
        #   SELECT store_name, sum(sales) FROM orders GROUP BY store_name HAVING sum(sales) > 10000

        User.select([:id, :name])
        => [#<User id: 1, name: "Oscar">, #<User id: 2, name: "Oscar">, #<User id: 3, name: "Foo">

        User.group(:name)
        => [#<User id: 3, name: "Foo", ...>, #<User id: 2, name: "Oscar", ...>]

        User.group('name AS grouped_name, age')
        => [#<User id: 3, name: "Foo", age: 21, ...>, #<User id: 2, name: "Oscar", age: 21, ...>, #<User id: 5, name: "Foo", age: 23, ...>]


      #find_by_sql
        #如果需要手動撰寫 SQL，可以使用find_by_sql和count_by_sql，例如：
        c8 = Category.find_by_sql("select * from categories")
        c8 = Category.count_by_sql("select * from categories")

      #from
        Topic.select('title').from(Topic.approved)
        # => SELECT title FROM (SELECT * FROM topics WHERE approved = 't') subquery

        Topic.select('a.title').from(Topic.approved, :a)
        # => SELECT a.title FROM (SELECT * FROM topics WHERE approved = 't') a

    #calculation
      #average
      Person.average(:age) # => 35.8

      #count
        Person.group(:city).count # => { 'Rome' => 5, 'Paris' => 3 }
        Article.group(:status, :category).count # =>  {["draft", "business"]=>10, ["draft", "technology"]=>4,
                                                #     ["published", "business"]=>0, ["published", "technology"]=>2}
        Person.distinct.count(:age)
        # => counts the number of different age values
        Person.count(:all)
        # => performs a COUNT(*) (:all is an alias for '*')
        Person.count(:age)
        # => returns the total count of all people whose age is present in database

      #max, min, sum
        Person.maximum(:age) # => 93
        Person.minimum(:age) # => 7
        Person.sum(:age) # => 4562

    #reload
      #這個方法可以將物件從資料庫裡重新載入一次：
      e = Event.first
      e.name = "test"
      e.reload

    #readonly
        #如此查詢出來的c就無法修改或刪除，不然會丟出ActiveRecord::ReadOnlyRecord例外。
        c = Category.readonly.first

    #find_each
      #如果資料量很大，但是又需要全部拿出來處理，可以使用 find_each 批次處理
      Category.where("position > 1").find_each do |category|
          category.do_some_thing
      end
      #預設會批次撈 1000 筆，如果需要設定可以加上 :batch_size 參數。
  end
end
