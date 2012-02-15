require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Github::Comment" do
  
  before(:each) do
    VCR.use_cassette('provider-for-comments') { @github = TicketMaster.new(:github, {:login => 'ticketmaster-user', :password => 'Tm123456'}) }
    VCR.use_cassette('project-for-comments') { @project = @github.projects.first }
    VCR.use_cassette('ticket-for-comments') { @ticket = @project.tickets.first }
    @klass = TicketMaster::Provider::Github::Comment
    @api = Octokit::Client
  end
  
  it "should be able to load all comments" do
    VCR.use_cassette('comments') { @comments = @ticket.comments } 
    @comments.should be_an_instance_of(Array)
    @comments.first.should be_an_instance_of(@klass)
  end
  
  it "should be able to create a new comment" do  
    pending 
  end
  
end
