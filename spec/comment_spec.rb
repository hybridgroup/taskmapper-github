require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Github::Comment" do
  before(:all) do
    @github =  TicketMaster.new(:github, {:login => 'juanespinosa', :token => 'asdfghk'})
    @klass = TicketMaster::Provider::Github::Comment
    @api = TicketMaster::Provider::Github::GithubComment
    @repository = Factory.build(:repository)
  end
  
  before(:each) do
    issue = Factory.build(:issue)
    issue.stub_chain(:repository, :name).and_return(issue.repository)
    @ticket =  TicketMaster::Provider::Github::Ticket.new issue
    @comment = Factory.build(:comment)
    @comments = [@comment]
    Octopi::Repository.stub!(:find_all).and_return([@repository])
  end
  
  it "should be able to load all comments" do
    @api.stub!(:find_all).and_return(@comments)
    @ticket.comments.should be_an_instance_of(Array)
    @ticket.comments.first.should be_an_instance_of(@klass)
  end
  
  it "should be able to create a new comment" do
    @api.stub!(:create).and_return(@comment)
    @comment = @ticket.comment!("A new comment")
    @comment.should be_an_instance_of(@klass)
  end
  
end