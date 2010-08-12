require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Github::Comment" do
  before(:all) do
    @ticket_id = "1"
    @comment_id = "335287"
    @github =  TicketMaster.new(:github, {:login => 'juanespinosa', :token => 'asdfghk'})
    @klass = TicketMaster::Provider::Github::Comment
  end
  
  before(:each) do
    @ticket = Factory.build(:ticket)
    @comment = Factory.build(:comment)
    @comments = [@comment]
  end
  
  it "should be able to load all comments" do
    @klass.stub!(:find_by_attributes).and_return(@comments)
    @ticket.comments.should be_an_instance_of(Array)
    @ticket.comments.first.should be_an_instance_of(@klass)
  end
  
  it "should be able to create a new comment" do
    @klass.stub!(:create).and_return(@comment)
    @comment = @ticket.comment!("A new comment")
    @comment.should be_an_instance_of(@klass)
  end
  
end