#used for mass assignment
class PeopleController < ApplicationController
  def show
    #restricted Content
      #@order = Order.find(params[:id])
      # if @order.user_id != current_user.id
      #   render :text => "你沒有權限"
      #   return
      # end

      # in fact can write as this
      @order = current_user.orders.find(params[:id])
    #symbolize problem
      #symbol是Ruby中常用的型態，相較於字串可以獲得更好的執行效率，
      #其佔用記憶體較少，但其特性是不會被GC(garbage collection)記憶體回收的。
      #因此只適合程式內部有限的情況中使用，而不要將使用者可以任意輸入的參數做symbol化，例如：
      if params[:category].to_sym == :first # 此例直接比較字串即可 params[:category] == "first"
         # do something
      end
      #這樣為什麼會有安全性問題呢？這是因為如果惡意的使用者不斷送出任意字元進行DoS(Denial of service attack)攻擊，
      #那麼程式就會不斷把params[:category]做symbolize，產生無法回收的記憶體，進而把記憶體全部用光。
    #sql injection
      #如果你有用到以下的方法，ActiveRecord是不會自動幫你逸出，要特別注意：

          find_by_sql
          execute
          where 用字串參數
          group
          order
      #你可以自定一些固定的參數，並檢查使用者輸入的資料，例如：
      class User < ActiveRecord::Base
        def self.find_live_by_order(order)
          raise "SQL Injection Warning" unless ["id","id desc"].include?(order)
          where( :status => "live" ).order(order)
        end
      end
      #或是手動呼叫ActiveRecord::Base::connection.quote方法：
      class User < ActiveRecord::Base
        def self.find_live_by_order(order)
          where( :status => "live" ).order( connection.quote(order) )
        end
      end
  end
end
