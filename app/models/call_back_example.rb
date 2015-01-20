 class CallBackExample < ActiveRecord::Base
  # 回呼 Callback

    # 在介紹過驗證之後，接下來讓我們來看看回呼。回呼可以在Model資料的生命週期，掛載事件上去，例如我們可以在資料儲存進資料庫前，做一些修正，或是再儲存成功之後，做一些其他動作。回呼大致可以分成三類：

    # 在Validation驗證前後
    # 在儲存進資料庫前後
    # 在從資料庫移除前後
    # 以下是當一個物件儲存時的流程，其中1~7就是回呼可以觸發的時機：

    # (-) save
    # (-) valid
    # (1) before_validation
    # (-) validate
    # (2) after_validation
    # (3) before_save
    # (4) before_create
    # (-) create
    # (5) after_create
    # (6) after_save
    # (7) after_commit
    # 來看幾個使用情境範例

  # 常用來清理資料或設定預設值：
    before_validation :setup_defaults

  #常用來觸發去相關聯資料的方法或資料：
    belongs_to :event
    after_save :check_event_status!

  #可以用來清理乾淨相關聯的資料
    after_destroy

    protected

    def setup_defaults
      self.name.try(:strip!) # 把前後空白去除
       self.description = self.name if self.description.blank?
      self.is_public ||= true
    end

    def check_event_status!
       self.event.check_event_status!
    end

  # 其他注意事項
    # 回呼的方法一般會放在protected或private下，確保從Model外部是無法呼叫的。
    # before_validation和before_save的差別在於後者不會經過Validation資料驗證。
    # 請避免before_開頭的回呼方法中，最後運算的結果不小心回傳false。這樣會中斷儲存程序。如果不確定的話，請回傳return true。這算是常見的地雷，而且不容易除錯(你會發現資料莫名地無法儲存成功)。
    # 其中after_rollback和after_commit這兩個回呼和Transaction交易有關。Rollback指的是在transaction區塊中發生例外時，Rails會將原先transaction中已經被執行的所有資料操作回復到執行transaction前的狀態，after_rollback就是讓你在rollback完成時所觸發的回呼，而after_commit是指在transaction完成後才觸發的回呼，關於transaction的部份請參考ActiveRecord進階功能一章的交易一節。
end
