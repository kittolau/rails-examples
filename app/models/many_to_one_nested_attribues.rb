class PostImage < ActiveRecord::Base
  mount_uploader :image, PostImagesUploader

  belongs_to :posts
end


class Post < ActiveRecord::Base
  has_many :post_images, :dependent => :destroy

  #now posts has a new attribute:
  #post_images_attributes
  #This can accept e.g:
  #{
  #    title:"aaa",
  #    post_images_attributes[0][_destroy]=1,
  #    post_images_attributes[0][id]=12,
  #    post_images_attributes[1][_destroy]=1,
  #    post_images_attributes[1[id]=13,
  #    post_images_attributes[2][image]=uploadedFile
  #}
  #
  #NOTICE!!!  allow_destroy must be used with :id and :_destory
  accepts_nested_attributes_for :post_images, allow_destroy: true
end

#In controller, allow the value for mass assignment
params.permit(:title, post_images_attributes:[:id, :_destroy,:image])

# the following is the form example for nested form
<%= form_for @article, :html => {:multipart => true} do |f| %>
<% if @article.errors.any? %>
<div id="error_explanation">
  <h2><%= pluralize(@article.errors.count, "error") %> prohibited this article from being saved:</h2>
  <ul>
    <% @article.errors.full_messages.each do |msg| %>
    <li>
      <%= msg %>
    </li>
    <% end %>
  </ul>
</div>
<% end %>
<div class="field">
  <%= f.label :title %>
  <br />
  <%= f.text_field :title %>
</div>
<div class="field">
  <%= f.label :body %>
  <br />
  <%= f.text_area :body %>
</div>
<%= f.fields_for :article_images do |article_image| %>

<% if article_image.object.new_record? %>

<%= article_image.file_field :image %>

<% else %>

<%= image_tag(article_image.object.image.url(:thumb)) %>
<%= article_image.check_box :_destroy %>

<% end %>

<% end %>

<%= f.submit %>

<% end %>
