class ActiveRecordExampleController < ActionController::Base
  def index
    hash = {}

    #merge another hash
      {a:123}.merge({b:456}) # => {a:123,b:456}

      #rail's deep merge
      {a:{a:1,b:2}}.deep_merge({a:{b:2,c:3}} ) # =>  {:a=>{:a=>1, :b=>2, :c=>3}}


  end
end
