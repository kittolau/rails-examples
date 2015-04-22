#多型關連(Polymorphic Associations)可以讓一個 Model 不一定關連到某一個特定的 Model，秘訣在於除了整數的_id外部鍵之外，再加一個字串的_type欄位說明是哪一種Model。

#例如一個Comment model，我們可以透過多型關連讓它belongs_to到各種不同的 Model上，假設我們已經有了Article與Photo這兩個Model，然後我們希望這兩個Model都可以被留言。不用多型關連的話，你得分別建立ArticleComment和PhotoComment的model。用多型關連的話，無論有多少種需要被留言的Model，只需要一個Comment model即可：

rails g model comment content:text commentable_id:integer commentable_type
#這樣會產生下面的 Migration 檔案：

class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :commentable_id
      t.string :commentable_type

      t.timestamps
    end
  end
end
#這個Migration檔案中，我們用content這個欄位來儲存留言的內容，
#commentable_id用來儲存被留言的物件的id
#commentable_type則用來儲存被留言物件的種類，
#以這個例子來說被留言的對象就是Article與Photo這兩種Model，
#這個Migration檔案也可以改寫成下面這樣：

class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.belongs_to :commentable, :polymorphic => true

      t.timestamps
    end
  end
end

#回到我們的Model，我們必須指定他們的關聯關係：

class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
end

class Article < ActiveRecord::Base
  has_many :comments, :as => :commentable
end

class Photo < ActiveRecord::Base
  has_many :comments, :as => :commentable
end

#這樣會告訴Rails如何去設定你的多型關係，現在讓我們進console實驗看看：
article = Article.first

# 透過關連新增留言
comment = article.comments.create(:content => "First Comment")

# 你可以發現 Rails 很聰明的幫我們指定了被留言物件的種類和id
comment.commentable_type => "Article"
comment.commentable_id => 1

# 也可以透過 commentable 反向回查關連的物件
comment.commentable => #<Article id: 1, ....>




#Many to Many Polymorphic
class ItemCountry < ActiveRecord::Base
  belongs_to :locatable, :polymorphic => true
  belongs_to :country
  # fields are :locatable_id, :locatable_type, :country_id
end

class Title < ActiveRecord::Base
  has_many :countries, :through => :item_countries, :as => :locatable
  has_many :item_countries, :as => :locatable
end

 class Country < ActiveRecord::Base
   has_many :titles, :through => :item_countries, :source => :locatable, :source_type => 'Title'
   has_many :item_countries, :foreign_key => :country_id
 end

 class CreateItemCountryAssociationTable < ActiveRecord::Migration
   def change
     create_table :item_countries, :id => false do |t|
       t.integer :locatable_id
       t.string  :locatable_type
       t.integer :country_id
     end
     add_index :item_countries, [:locatable_id, :locatable_type, :country_id], :name => 'polymorphic_many_to_many_idx'
     add_index :item_countries, [:locatable_id, :locatable_type], :name => 'polymorphic_locatable_idx'
   end
 end
