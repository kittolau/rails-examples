#如果需要常計算has_many的Model有多少筆資料，例如顯示文章列表時，
#也要顯示每篇有多少留言回覆。
<% @topics.each do |topic| %>
  主題：<%= topic.subject %>
  回覆數：<%= topic.posts.size %>
<% end %>
#這時候Rails會產生一筆筆的SQL count查詢：
SELECT * FROM `posts` LIMIT 5 OFFSET 0
SELECT count(*) AS count_all FROM `posts` WHERE (`posts`.topic_id = 1 )
SELECT count(*) AS count_all FROM `posts` WHERE (`posts`.topic_id = 2 )
SELECT count(*) AS count_all FROM `posts` WHERE (`posts`.topic_id = 3 )
SELECT count(*) AS count_all FROM `posts` WHERE (`posts`.topic_id = 4 )
SELECT count(*) AS count_all FROM `posts` WHERE (`posts`.topic_id = 5 )

#Counter cache功能可以把這個數字存進資料庫，不再需要一筆筆的SQL count查詢，
#並且會在Post數量有更新的時候，自動更新這個值。

#首先，你必須要在Topic Model新增一個欄位叫做posts_count，
#依照慣例是_count結尾，型別是integer，有預設值0。
rails g migration add_posts_count_to_topic
#編輯Migration：
class AddPostsCountToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :posts_count, :integer, :default => 0

    Topic.pluck(:id).each do |i|
      Topic.reset_counters(i, :posts) # 全部重算一次
    end
  end
end
#編輯Models，加入:counter_cache => true：
class Topic < ActiveRecord::Base
  has_many :posts
end

class Posts < ActiveRecord::Base
  belongs_to :topic, :counter_cache => true
end
#這樣同樣的@topic.posts.size程式，就會自動變成使用@topic.posts_count，
#而不會用SQL count查詢一次。
