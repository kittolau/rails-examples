class RelationalActiveRecordExampleController < ActionController::Base
  def index

  #association
      #include
        #Joins brings association data using LEFT OUTER JOIN
        #Specify relationships to be included in the result set. For example:

        users = User.includes(:address)
        users.each do |user|
          user.address.city
        end
        #allows you to access the address attribute of the User model without firing an additional query.
        #This will often result in a performance improvement over a simple join.

        #You can also specify multiple relationships, like this:
        users = User.includes(:address, :friends)

        #Loading nested relationships is possible using a Hash:
        users = User.includes(:address, friends: [:address, :followers])

        #If you want to add conditions to your included models you'll have to explicitly reference them. For example:

        #User.includes(:posts).where('posts.name = ?', 'example')
        #Will throw an error, but this will work:

        User.includes(:posts).where('posts.name = ?', 'example').references(:posts)
        #Note that includes works with "association names" while references needs the "actual table name".

      #Preload
        #Preload loads the association data in a separate query.
        User.preload(:posts).to_a
        # =>
        #SELECT "users".* FROM "users"
        #SELECT "posts".* FROM "posts"  WHERE "posts"."user_id" IN (1)

      #join
        #Joins brings association data using inner join.
        User.joins(:posts)
        # => SELECT "users".* FROM "users" INNER JOIN "posts" ON "posts"."user_id" = "users"."id"
        #In the above case no posts data is selected. Above query can also produce duplicate result.
        #We can avoid the duplication by using distinct .
        User.joins(:posts).select('distinct users.*').to_a

        records = User.joins(:posts).select('distinct users.*, posts.title as posts_title').to_a
        records.each do |user|
          puts user.name
          puts user.posts_title
        end
        #Note that using joins means if you use user.posts then another query will be performed.

        #more complex join
        joins(:category, reviews: :user)

        joins("
          left join
          (
            SELECT
              post_source_id,post_id,post_created_time,text_content
            FROM
              buzzviz_development.posts
            group by
              post_source_id
            order by created_at DESC
          ) as p
          on p.post_source_id = post_sources.post_source_id
          ")

        #dynamic subquery
        subquery = Post
          .select("posts.users_id,posts.post_source_id,posts.post_created_time,Sum(lc.liked_count) AS user_post_being_liked_count")
          .joins("
            INNER JOIN (SELECT *,
                         Count(upss.post_id) AS liked_count
                  FROM   user_post_sharing_ships AS upss
                  GROUP  BY upss.post_id ) AS lc
              ON posts.post_id = lc.post_id
            ")
          .group("posts.users_id")
          .merge(Post.apply_global_scope(get_global_scope))

        @users = User
          .includes(:post_sources)
          .select("users.*, posts.user_post_being_liked_count")
          .joins("
            inner join
            (#{subquery.to_sql}) AS posts
             ON posts.users_id = users.user_id
            ")
          .order(user_post_being_liked_sortable_column+" "+sortable_direction)
          .page(params[:page])
          .per(30)

        #Also if we want to make use of attributes from posts table then we need to select them.
  # has_many 的集合物件
    #在關聯的集合上，我們有以下方法可以使用：
    e = Event.first

    #create relationship
        #insert promptly
            e.attendees << Attendee.new
            #The most important part, however, is that these methods can be called through an association (has_many, etc.) to automatically link the two models.
            e.attendees.create # .create is equivalent to .new followed by .save. It's just more succinct.
            e.attendees.create! # .create! is equivalent to .new followed by .save! (throws an error if saving fails). It's also just a wee bit shorter

        #need to save
            e.attendees.build #.build is mostly an alias for .new
            e.save

        e.attendees.new
    #remove relationship
        e.attendees.delete_all # The row is simply removed with an SQL DELETE statement on the record's primary key, and no callbacks are executed.
        e.attendees.destroy_all # There's a series of callbacks associated with destroy. If the before_destroy callback return false the action is cancelled and destroy returns false

    #query
        e.attendees.find(id)
        e.attendees.any?
        e.attendees.empty?
        e.attendees.include?(record)
        e.attendees.first, last
        e.attendees.ids

    #stat
    e.attendees.count

    #reload
    e.attendees.reload

  # has_one 的集合物件
    # 多了兩個方法可以新增關聯物件：

    build_{association_name}
    create_{association_name}
    # 例如：
    # e = Event.first
    # e.build_location
  end
end
