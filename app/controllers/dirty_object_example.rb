class DirtyObjectController < ApplicationController
  def create
    person = Person.find_by_name('Uncle Bob')
    person.changed?       # => false 沒有改變任何值

    # 讓我們來改一些值
    person.name = 'Bob'
    person.changed?       # => true 有改變
    person.name_changed?  # => true 這個屬性有改變
    person.name_was       # => 'Uncle Bob' 改變之前的值
    person.name_change    # => ['Uncle Bob', 'Bob']
    person.name = 'Bill'
    person.name_change    # => ['Uncle Bob', 'Bill']

    # 儲存進資料庫
    # 注意到Model資料一旦儲存進資料庫，追蹤記錄就重算消失了。
    person.save
    person.changed?       # => false
    person.name_changed?  # => false

    # 看看哪些屬性改變了
    person.name = 'Bob'
    person.changed        # => ['name']
    person.changes        # => { 'name' => ['Bill', 'Bob'] }

    #什麼時候會用到這個功能呢？通常是在儲存進資料庫前的回呼、驗證或Observer中，
    #你想根據修改了什麼來做些動作，這時候Dirty Objects功能就派上用場了。
  end


end
