class Event < ActiveRecord::Base
    def as_json(options = {})
      #override the json serialization, provide a new atrribute called release_on by using release_at
      super.merge()
      JSON::parse(@todo.to_json).merge({release_on: release_at.to_date}).to_json

    end

  #serialize the method
  def as_json(options = {})
    super(:methods => [:f_created_at,:f_updated_at])
  end

  def f_created_at
    "aaaa"
  end

  def f_updated_at


  end
end
