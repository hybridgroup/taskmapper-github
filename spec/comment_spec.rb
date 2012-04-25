require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Github::Comment" do

  before(:each) do
    @github = TicketMaster.new(:github, {:login => 'ticketmaster-user', :password => 'Tm123456'})
    stub_get('https://ticketmaster-user:Tm123456@api.github.com/users/ticketmaster-user/repos', 'projects.json')
    stub_get('https://ticketmaster-user:Tm123456@api.github.com/repos/ticketmaster-user/tmtest-repo/issues','issues.json')
    stub_get('https://ticketmaster-user:Tm123456@api.github.com/repos/ticketmaster-user/tmtest-repo/issues?state=closed','closed_issues.json')
    stub_get('https://ticketmaster-user:Tm123456@api.github.com/repos/ticketmaster-user/tmtest-repo/issues/1/comments', 'comments.json')
    stub_post('https://ticketmaster-user:Tm123456@api.github.com/repos/ticketmaster-user/tmtest-repo/issues/1/comments', 'comments/3951282.json')
    @project = @github.projects.first
    @ticket = @project.tickets.first
    @klass = TicketMaster::Provider::Github::Comment
    @api = Octokit::Client
  end

  it "should be able to load all comments" do
    @comments = @ticket.comments
    @comments.should be_an_instance_of(Array)
    @comments.first.should be_an_instance_of(@klass)
  end
  
  it "should be able to create a new comment" do  
    comment = @ticket.comment!(:body => 'new comment')
    comment.should be_an_instance_of(@klass)
  end
  
  it "should be able to update comments" do
    comment = @ticket.comments.first
    comment.body = "updated comment"
    comment.save.should be_true
    comment.body.should == "updated comment"
  end

end
