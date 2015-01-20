#used for mass assignment
class TransactionExampleController < ApplicationController
  def create
      ActiveRecord::Base.transaction do
        david.withdrawal(100)
        mary.deposit(100)
      end

      #注意到這裡我們要使用create!而不是create，這是因為前者驗證失敗才會丟出例外，好讓整個交易失敗。
      #同理，在交易裡做更新應該使用update!而不是update。
      User.transaction do
        User.create!(:name => 'ihower')
        Feed.create!
        User.update!(:name => 'ihower')
        Feed.update!
      end

      #另外，由於資料的更新要在交易完成後才能被讀取到，所以如果你在after_save回呼裡讓外部服務存取(例如呼叫全文搜尋引擎做索引)
      #，很可能因為交易尚未完成，會讀取不到更新。
      #這時候必須改用after_commit這個回呼，才能確保讀取到交易完成後的資料。
  end


end
