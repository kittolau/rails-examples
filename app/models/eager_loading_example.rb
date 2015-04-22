class Product < ActiveRecord::Base

  belongs_to :category
  has_many :reviews

  #if want to eager load the result, then use @product.category_nameS instead of @product.category.name
  def category_name
    read_attribute("category_name") || category.name
  end

  #also it is better to put complex query in model instead of in controller
  def get_index_events
    Product.order("categories.name").joins(:category, reviews: :user).select("products.*, category_name")
  end
end
