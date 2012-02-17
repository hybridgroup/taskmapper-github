require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Github::Comment" do
  
  before(:each) do
    @github = TicketMaster.new(:github, {:login => 'ticketmaster-user', :password => 'Tm123456'})
    stub_get('https://ticketmaster-user:Tm123456@api.github.com/users/ticketmaster-user/repos', 'projects.json')
    stub_get('https://ticketmaster-user:Tm123456@api.github.com/repos/ticketmaster-user/tmtest-repo/issues','issues.json')
    stub_get('https://ticketmaster-user:Tm123456@api.github.com/repos/ticketmaster-user/tmtest-repo/issues?state=closed','closed_issues.json')
    @project = @github.projects.first
    @ticket = @project.tickets.first
    @klass = TicketMaster::Provider::Github::Comment
    @api = Octokit::Client
  end
  
  it "should be able to load all comments" do
    stub_get('https://ticketmaster-user:Tm123456@api.github.com/repos/ticketmaster-user/tmtest-repo/issues/1/comments', 'comments.json')
    @comments = @ticket.comments
    @comments.should be_an_instance_of(Array)
    @comments.first.should be_an_instance_of(@klass)
  end
  
  it "should be able to create a new comment" do  
    pending 
  end
  
end
