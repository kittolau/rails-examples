class STIExample < ActiveRecord::Base

  # 單一表格繼承STI(Single-table inheritance)

  # 如何將物件導向中的繼承概念，對應到關聯式資料庫的設計，是個大哉問。Rails內建了其中最簡單的一個解法，只用一個資料表儲存繼承體系中的物件，搭配一個type欄位用來指名這筆資料的類別名稱。

  # 要開啟STI功能，依照慣例只要有一個欄位叫做type，型態字串即可。假設以下的posts資料表有欄位叫做type，那麼這三個Models實際上就會共用posts一個資料表，當然，還有這兩個子類別也都繼承到父類別的validates_presence_of :subject：

  class Post < ActiveRecord::Base
      validates_presence_of :subject
  end

  class GuestPost < Post
  end

  class MemberPost < Post
  end

  # 讓我們進入rails console實驗看看，Rails會根據你使用的類別，自動去設定type欄位：

  # post = GuestPost.create( :subject => "guest")
  # post.type # "GuestPost"
  # post.id # 1
  # post = MemberPost.create( :subject => "member" )
  # post.id # 2
  # post.type # "MemberPost"
  # GuestPost.last # 1

  # 很遺憾，也因為這個慣例的關係，你不能將type這麼名字挪做它用。
  # STI最大的問題在於欄位的浪費，如果繼承體系中交集的欄位不多，那麼使用STI就會非常的浪費空間。如果有較多的不共用的欄位，筆者會建議不要使用這個功能，讓個別的類別有自己的資料表。

  #要關閉STI，請父類別加上self.abstract_class = true
  class Post < ActiveRecord::Base
      self.abstract_class = true
      validates_presence_of :subject
  end

  class GuestPost < Post
  end

  class MemberPost < Post
  end
  # 這裡的GuestPost和MemberPost就需要有自己的Migrations建立guest_posts和member_posts資料表。

end
