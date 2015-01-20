class RelationExample < ActiveRecord::Base

  #如果你的資料表不使用這個命名慣例，例如連接到舊的資料庫，或是主鍵欄位不是id，也可以手動指定：
  self.table_name = "your_table_name"
  self.primary_key = "your_primary_key_name"

  #order
    # has_many可以透過:order參數指定順序：
    has_many :attendees, :order => "id desc"

  # dependent
    # 可以設定當物件刪除時，也會順便刪除它的has_many物件：
    has_many :attendees, :dependent => :destroy
    # :dependent可以有三種不同的刪除方式，分別是：
    # :destroy 會執行attendee的destroy回呼
    # :delete 不會執行attendee的destroy回呼
    # :nullify 這是預設值，不會幫忙刪除attendee
    # 要不要執行attendee的刪除回呼效率相差不少，如果需要的話，必須一筆筆把attendee讀取出來變成attendee物件，然後呼叫它的destroy。如果用:delete的話，只需要一個SQL語句就可以刪除全部attendee。

  # where
    # 這可以加上額外的條件在關聯上，例如
    has_many :paid_attendees, -> { where(:status => "paid") }, :class_name => 'Attendee'

  # through
    # 透過關聯來建立另一個關聯集合，用於建立"多對多"的關係。
    has_many :event_groupships
    has_many :groups, :through => :event_groupships

  # source
    # 搭配through設定使用，當關聯的名稱不一致的時候，需要加上source指名是哪一種物件。
    has_many :event_groupships
    # :source 是 event_groupships 其中一個belong_to的名
    has_many :classifications, :through => :event_groupships, :source => :group

  # has_many 的設定
    has_many :paid_attendees #default as PaidAttendee Class
    # 可以變更關聯的類別名稱，例如：
    has_many :paid_attendees, :class_name => "Attendee" # 外部鍵是user_id
    # 可以變更Foreign Key的欄位名稱，例如改成user_id：
    has_many :paid_attendees, :class_name => "Attendee", :foreign_key => "user_id"
    # 可以變更用來 join 的 primary key (注意 has_many 也要用一樣的setting)
    # primary_key 是 belongs_to table的key
    # foreign_key 是 has_many table的key
    belongs_to :posts, class_name: "Post" , primary_key: "post_id", foreign_key: "post_id"
    has_many :comments, class_name: "Comment", primary_key: "post_id", foreign_key: "post_id"

  # belogns_to 的設定
    # class_name
    # 可以變更關聯的類別名稱，例如：
    belongs_to :manager, :class_name => "User" # 外部鍵是user_id

    # foreign_key
    # 可以變更Foreign Key的欄位名稱，例如改成manager_id：
    belongs_to :manager, :class_name => "User", :foreign_key => "manager_id"

    # touch
    # 這會在修改時，也順道修改關聯資料的updated_at時間：
    belongs_to :event, :touch => true

    # counter_cache
      # 針對關聯作計數的快取，假設Event身上有attendees_count這個欄位，那麼：
      class Attendee < ActiveRecord::Base
        belongs_to :event, :counter_cache => true
      end
      # 這樣ActiveRecord就會自動更新attendees_count的數字。
      # Counter cache

      # 如果需要常計算has_many的Model有多少筆資料，例如顯示文章列表時，也要顯示每篇有多少留言回覆。

      # <% @topics.each do |topic| %>
      #   主題：<%= topic.subject %>
      #   回覆數：<%= topic.posts.size %>
      # <% end %>
      # 這時候Rails會產生一筆筆的SQL count查詢：

      # SELECT * FROM `posts` LIMIT 5 OFFSET 0
      # SELECT count(*) AS count_all FROM `posts` WHERE (`posts`.topic_id = 1 )
      # SELECT count(*) AS count_all FROM `posts` WHERE (`posts`.topic_id = 2 )
      # SELECT count(*) AS count_all FROM `posts` WHERE (`posts`.topic_id = 3 )
      # SELECT count(*) AS count_all FROM `posts` WHERE (`posts`.topic_id = 4 )
      # SELECT count(*) AS count_all FROM `posts` WHERE (`posts`.topic_id = 5 )
      # Counter cache功能可以把這個數字存進資料庫，不再需要一筆筆的SQL count查詢，並且會在Post數量有更新的時候，自動更新這個值。

      # 首先，你必須要在Topic Model新增一個欄位叫做posts_count，依照慣例是_count結尾，型別是integer，有預設值0。

      # rails g migration add_posts_count_to_topic
      # 編輯Migration：

      # class AddPostsCountToTopic < ActiveRecord::Migration
      #   def change
      #     add_column :topics, :posts_count, :integer, :default => 0
      #   end
      # end
      # 編輯Models，加入:counter_cache => true：

      # class Topic < ActiveRecord::Base
      #   has_many :posts
      # end

      # class Posts < ActiveRecord::Base
      #   belongs_to :topic, :counter_cache => true
      # end
      # 這樣同樣的@topic.posts.size程式，就會自動變成使用@topic.posts_count，而不會用SQL count查詢一次。

end
