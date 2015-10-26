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
    #must use scoping function inside ->{ },
    #NOTICE, includes(:paid_attendees) used with -> { where(:status => "paid").limit(1) } will make limit(1) become useless

  # through
    #!!!IF relation is the name of the related table
    # 透過關聯來建立另一個關聯集合，用於建立"多對多"的關係。
    has_many :event_groupships
    has_many :groups, :through => :event_groupships

    #!!!IF relation is NOT the name of the related table
    # source
      # 搭配through設定使用，當關聯的名稱不一致的時候，需要加上source指名是哪一種物件。
      # The source means the name of the relationship that is wanted
      # e.g. has_many classifications is infact has_many group, so group is the source
      has_many :event_groupships
      # :source 是 event_groupships 其中一個belong_to的名
      has_many :classifications, :through => :event_groupships, :source => :group

  # has_many 的設定
    #!!!IF relation is the name of the related table
    has_many :paid_attendees #default as PaidAttendee Class
    # 可以變更關聯的類別名稱，例如：
    #!!!IF relation is NOT the name of the related table
    has_many :othername_attendees, :class_name => "Attendee" # 外部鍵是user_id
    # 可以變更Foreign Key的欄位名稱，例如改成user_id：
    has_many :othername_attendees, :class_name => "Attendee", :foreign_key => "user_id"
    # 可以變更用來 join 的 primary key (注意 has_many 也要用一樣的setting)
    # primary_key 是 has_many table的key, default id (this is a primary key refering to this relationship)
    # foreign_key 是 belong_to table的key defaut XXX_id(NOTICE no 's') (this is a foreign key refering to this relationship)
    #in Comment model
    # NOTICE, belongs_to has no 's' in the end
    belongs_to :post, class_name: "Post" , primary_key: "post_id", foreign_key: "post_id"
    #in Post Model
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

end
