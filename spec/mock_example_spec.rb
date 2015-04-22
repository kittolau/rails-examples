require File.dirname(__FILE__) + '/mock_example.rb'


describe Hello do
  context "saying hello" do 
    before(:each) do
      @hello = mock(Hello)
      @hello.stub!(:say).and_return("hello world")
    end

    it "#say should return hello world" do
      @hello.should_receive(:say).and_return("hello world")
      answer = @hello.say
      answer.should match("hello world")
    end
  end
end