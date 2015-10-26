class Topic < ActiveRecord::Base
  def visit
    self.class.increment_counter(:visit_count, self.id)
  end
end

#then in controller
class TopicsController < ApplicationController
  after_filter :only => :show do
    @topic.visit
  end
end
