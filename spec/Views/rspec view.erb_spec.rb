#spec/views/chats/show.html.erb_spec.rb
describe "views/chats/show.html.erb" do
  #fixtures :examples
  #the fixture should be the name same as the file name in fixtures
  

  before(:each) do
    #the name in the fixture

    #@chat = chats(:one)
    render "/events/index.html.erb"
  end

  it "should render attributes in paragraph" do
    response.should have_text(/MyString/)
  end

  it "should render all messages for the chat" do
    response.should have_tag("tr>td", "Hello!", 1)
    response.should have_tag("tr>td", "How are you?", 1)
    response.should have_tag("tr>td", "Excellent!", 1)
  end

end