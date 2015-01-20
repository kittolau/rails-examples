module DateExtension

  extend ActiveSupport::Concern

  # add your instance methods here
  def to_sql_date
     self.strftime("%Y-%m-%d")
  end

  def to_sql_date_time
    self.strftime("%Y-%m-%d %H:%M:%S")
  end

  # add your static(class) methods here
  module ClassMethods
    #E.g: Order.top_ten
    def top_ten
      limit(10)
    end
  end
end

# include the extension
Date.send(:include, DateExtension)

#Then create config/initializers/extension.rb
#And add a line require "date_extension"

