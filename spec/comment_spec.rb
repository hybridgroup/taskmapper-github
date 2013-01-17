require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TaskMapper::Provider::Github::Comment do

  before(:each) do
    @github = TaskMapper.new(:github, {:login => 'taskmapper-user', :password => 'Tm123456'})
    stub_get('https://taskmapper-user:Tm123456@github.com/api/v2/json/organizations/repositories', 'repositories.json')
    stub_get('https://taskmapper-user:Tm123456@api.github.com/repos/taskmapper-user/tmtest-repo', 'project.json')
    stub_get('https://taskmapper-user:Tm123456@api.github.com/repos/taskmapper-user/tmtest-repo/issues?since','issues.json')
    stub_get('https://taskmapper-user:Tm123456@api.github.com/repos/taskmapper-user/tmtest-repo/issues?state=closed','closed_issues.json')
    stub_get('https://taskmapper-user:Tm123456@api.github.com/repos/taskmapper-user/tmtest-repo/issues/1/comments', 'comments.json')
    stub_post('https://taskmapper-user:Tm123456@api.github.com/repos/taskmapper-user/tmtest-repo/issues/1/comments', 'comments/3951282.json')
    stub_post('https://taskmapper-user:Tm123456@api.github.com/repos/taskmapper-user/tmtest-repo/issues/comments/3951282', 'comments/3951282_update.json')
    @project = @github.project('tmtest-repo')
    @ticket = @project.tickets.first
    @klass = TaskMapper::Provider::Github::Comment
    @api = Octokit::Client
  end

  it "should be able to load all comments" do
    comments = @ticket.comments
    comments.should be_an_instance_of(Array)
    comments.first.should be_an_instance_of(@klass)
    comments.first.body.should == "for testing"
  end
  
  it "should be able to create a new comment" do  
    comment = @ticket.comment!(:body => 'for testing')
    comment.should be_an_instance_of(@klass)
    comment.body.should == 'for testing'
  end
  
  #see bug 116 tm-github: Bug Ticket#comments returning comments with weird text in the body
  it "should be able to load a ticket and clean comment body" do
    comments = @ticket.comments.map(&:body).should == ["for testing", "test comment"]
  end
  
  it "should be able to update comments" do
    comment = @ticket.comments.first
    comment.body = "updated comment"
    comment.save.should be_true
  end

end
