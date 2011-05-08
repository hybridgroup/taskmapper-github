require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Github::Comment" do
  
  before(:each) do
    @github = TicketMaster.new(:github, {:login => 'cored', :token => 'kdkdkd'})
    @klass = TicketMaster::Provider::Github::Comment
    @api = Octokit::Client
  end
  
  it "should be able to load all comments" do
    pending
  end
  
  it "should be able to create a new comment" do
    pending
  end
  
end
