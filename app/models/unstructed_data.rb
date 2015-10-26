#序列化(Serialize)通常指的是將一個物件轉換成一個可被資料庫儲存及傳輸的純文字形態，
#反之將這筆資料從資料庫讀出後轉回物件的動作我們就稱之為反序列(Deserialize)，Rails提供了serialize讓你指定需要序列化資料的欄位，
#任何物件在存入資料庫時就會自動序列化成YAML格式，而當從資料庫取出時就會自動幫你反序列成原先的物件。
#這個欄位通常用text型態，有比較大的空間可以儲存資料，然後將一個Hash物件序列化之後存進去。
#
#常用的情境例如雜七雜八的使用者settings：
class User < ActiveRecord::Base
  #serialize
    #store into the field called settings
    serialize :settings

    #雖然序列化很方便可以讓你儲存任意的物件，但是缺點是序列化資料就失去了透過資料庫查詢索引的功效，
    #你無法在SQL的where條件中指定序列化後的資料。
    #
    #> user = User.create(:settings => { "sex" => "male", "url" => "foo" })
    #> User.find(user.id).settings # => { "sex" => "male", "url" => "foo" }

  #store
    #Store又在包裹了上一節的序列化功能，是個簡單又實用的功能，
    #讓你可以將某個欄位指定儲存為Hash值。舉例來說，上一節的settings也可以改用store來設定：
    #
    #特別的是其中accessors用來設定可以直接存取的屬性，
    #這樣就可以像平常一樣那樣操作sex和url這兩個屬性，讓我們進console實驗看看
    store :settings, :accessors => [:sex, :url]

    # > user = User.new(:sex => "male", :url => "http://example.com")
    # > user.sex
    #  => "male"
    # > user.url
    #  => "http://example.com"
    # > user.settings
    #  => {:sex => "male", :url => "http://example.com"}

    #因為store就像使用hash一樣，你也可以直接操作它，加入新的資料：
    # > user.settings[:food] = "pizza"
    # > user.settings
    #  => {:sex => "male", :url => "http://example.com", :food => "pizza"}
end


