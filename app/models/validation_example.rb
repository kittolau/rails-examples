class ValidationExample < ActiveRecord::Base
  # Validation 資料驗證
    # ActiveRecord 的 Validation 驗證功能，透過 Rails 提供的方法，你可以設定資料的規則來檢查資料的正確性。如果驗證失敗，就無法存進資料庫。

    # 那在什麼時候會觸發這個行為呢？Rails在儲存的時候，會自動呼叫model物件的valid?方法進行驗證，並將驗證結果放在errors裡面。所以我們前一章可以看到

    # > e = Event.new
    # > e.errors # 目前還是空的
    # > e.errors.empty? # true
    # > e.valid? # 進行驗證
    # > e.errors.empty? # false
    # > e.errors.full_messages # 拿到所有驗證失敗的訊息
    # 和 Database integrity 不同，這裡是在應用層設計驗證功能，好處是撰寫程式非常容易，Rails 已經整合進 HTML 表單的使用者介面。但是如果你的資料庫不只有 Rails 讀取，那你除了靠 ActiveRecord 之外，也必須要 DB 層實作 integrity 才能確保資料的正確性。
    # 確保必填

  # 忽略資料驗證
    # 透過:validate參數我們可以在save時忽略資料驗證：
    # > event.save( :validate => false )

    # 如果透過update_column更新特定欄位的值，也會忽略資料驗證：
    # > event.update_column( :name , nil )

  # Validation Example
    # validates_presence_of 是最常用的規則，用來檢查資料為非 nil 或空字串。
    validates_presence_of :name
    validates_presence_of :login
    validates_presence_of :email
    validates_presence_of :name, :login, :email

    # 確保字串長度
    validates_length_of :name, :minimum => 2 # 最少 2
    validates_length_of :bio, :maximum => 500 # 最多 500
    validates_length_of :password, :in => 6..20 # 介於 6~20
    validates_length_of :registration_number, :is => 6 # 剛好 6

    # 確保數字
    validates_numericality_of :points
    validates_numericality_of :games_played, :only_integer => true # 必須是整數
    # 除了 greater_than，還有 greater_than_or_equal_to, equal_to, less_than, less_than_or_equal_to 等參數可以使用。
    validates_numericality_of :age, :greater_than => 18
    validates_numericality_of :age, :greater_than_or_equal_to => 18
    validates_numericality_of :age, :equal_to => 18
    validates_numericality_of :age, :less_than => 18
    validates_numericality_of :age, :less_than_or_equal_to => 18

    # 確保唯一
    validates_uniqueness_of :email
    # 檢查資料在資料表中必須唯一。:scope 參數可以設定範圍，例如底下的 :scope => :year 表示，在 Holiday 資料表中，相同 year 的 name 必須唯一。
    validates_uniqueness_of :name, :scope => :year
    # 另外還有個參數是 :case_sensitive 預設是 true，表示要區分大小寫。
    validates_uniqueness_of :name, :case_sensitive => :false
    # 這條規則並沒有辦法百分百確定唯一，如果很接近的時間內有多個 Rails processes 一起更新資料庫，就有可能發生重複的情況。比較保險的作法是資料庫也要設定唯一性。


    # 確保格式正確
    # 透過正規表示法檢查資料的格式是否正確，例如可以用來檢查 Email、URL 網址、郵遞區號、手機號碼等等格式的正確性。
    # 正規表示法(regular expression)是一種用來比較字串非常有效率的方式，讀者可以利用 Rubular 進行練習。
    validates_format_of :email, :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
    validates_format_of :url, :with =>  /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix

    # 確保資料只能是某些值
    # 用來檢查資料必須只能某些值，例如以下的 status 只能是 pending 或 sent。
    validates_inclusion_of :status, :in => ["pending", "sent"]
    # 另外還有較少用到的 validates_exclusion_of 則是確保資料一定不會是某些值。
    validates_exclusion_of :status, :in => ["pending", "sent"]

    # 用來讓使用者必須核選一個 checkbox 方塊，例如已閱讀使用者條款
    validates_acceptance_of :terms_of_service
    # 用在需要讓使用者在表單輸入兩次的情況，例如密碼確認。
    validates_confirmation_of :password


  # 可共用的驗證參數
    # 以下這些參數都可以用在套用在上述的驗證方法上：

    # allow_nil
    # 允許資料是 nil。也就是如果資料是 nil，那就略過這個檢查。
    validates_inclusion_of :size, :in => %w(small medium large), :message => "%{value} is not a valid size", :allow_nil => true

    # allow_blank
    # 允許資料是 nil 或空字串。
    validates_length_of :title, :is => 5, :allow_blank => true
    # Topic.create("title" => "").valid? # => true
    # Topic.create("title" => nil).valid? # => true

    # message
    # 設定驗證錯誤時的訊息，若沒有提供則會用 Rails 內建的訊息。
    validates_uniqueness_of :email, :message => "你的 Email 重複了"

    # on
    # 可以設定只有新建立(:create)或只有更新時(:update)才驗證。預設值是都要檢查(:save)。
    validates_uniqueness_of :email, :on => :create

    # if, unless
    # 可以設定只有某些條件下才進行驗證
    validates_presence_of :description, :if => :normal_user?
    def normal_user?
        !self.user.try(:admin?)
    end


  # 整合寫法
    # 在 Rails3 之後支援以下的整合寫法：
    validates :name,  :presence => true,
                      :length => {:minimum => 1, :maximum => 254}

    validates :email, :presence => true,
                       :length => {:minimum => 3, :maximum => 254},
                       :uniqueness => true,
                       :email => true
    # 如果需要客製化錯誤訊息的話：
    validates :name,  :presence => { :message => "不能空白" } ,
                      :length => {:minimum => 1, :maximum => 254, :message => "長度不正確" }


  # 自定 validation
    # 使用 validate 方法傳入一個同名方法的 Symbol 即可。
    validate :my_validation
    private
    def my_validation
        if name =~ /foo/
            errors[:name] << "can not be foo"
        elsif name =~ /bar/
            errors[:name] << "can not be bar"
        elsif name == 'xxx'
            errors[:base] << "can not be xxx"
        end
    end
    # 在你的驗證方法之中，你會使用到 errors 來將錯誤訊息放進去，如果這個錯誤是因為某一屬性造成，我們就用那個屬性當做 errors 的 key，例如本例的 :name。如果原因不特別屬於某一個屬性，照慣例會用 :base。


  # 資料庫層級的驗證
    # 在本章開頭就有提到，Rails的驗證只是在應用層輸入資料時做檢查，沒有辦法保證資料庫裡面的資料一定是正確的。如果您想要在這方面嚴謹一些，可以在migration新增欄位時，加上:null => false確保有值、:limit參數限制長度，或是透過Unique Key確保唯一性，例如：
    #         create_table :registrations do |t|
    #           t.string :name, :null => false, :limit => 100
    #           t.integer :serial
    #           t.timestamps
    #         end
    #         add_index :registrations, :serial, :unique => true
    # 這樣資料庫就會確認name必須有值(不能是NULL)，長度不能大於100 bytes。serial是唯一的。
end
