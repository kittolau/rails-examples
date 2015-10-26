class ReturnExampleController < ApplicationController
  #params
    #正確的說，params這個Hash是ActiveSupport::HashWithIndifferentAccess物件，而不是普通的Hash而已。
    #Ruby內建的Hash，用Symbol的hash[:foo]和用字串的hash["foo"]是不一樣的，這在混用的時候常常搞錯而取不到值，算是常見的臭蟲來源。
    #Rails在這裡使用的ActiveSupport::HashWithIndifferentAccess物件，無論鍵是Symbol或字串，都指涉相同的值，減少麻煩。

    params[:query_string_key]
    #fetch
      #Returns a parameter for the given key. If the key can't be found, there are several options:
      # => With no other arguments, it will raise an ActionController::ParameterMissing error;
      # => if more arguments are given, then that will be returned;
      # => if a block is given, then that will be run and its result returned.
      params = ActionController::Parameters.new(person: { name: 'Francesco' })
      params.fetch(:person)               # => {"name"=>"Francesco"}
      params.fetch(:none)                 # => ActionController::ParameterMissing: param not found: none
      params.fetch(:none, 'Francesco')    # => "Francesco"
      params.fetch(:none) { 'Francesco' } # => "Francesco"
    #slice
      #Returns a new ActionController::Parameters instance that includes only the given keys. If the given keys don't exist, returns an empty hash.
      params = ActionController::Parameters.new(a: 1, b: 2, c: 3)
      params.slice(:a, :b) # => {"a"=>1, "b"=>2}
      params.slice(:d)     # => {}
end
