#使用form_for時，其中的欄位必須是Model有的屬性，
#那如果資料庫沒有這個欄位呢?這時候你依需要在Model程式中加上存取方法，例如：
class Event < ActiveRecord::Base
    #...
    def custom_field
        # 根據其他屬性的值或條件，來決定這個欄位的值
    end

    def custom_field=(value)
        # 根據value，來調整其他屬性的值
    end
end

#這樣就可以在form_for裡使用custom_field了。
<%= form_for @event do |f| %>
    <%= f.text_field :custom_field %>
    <%= f.submit %>
<% end %>
