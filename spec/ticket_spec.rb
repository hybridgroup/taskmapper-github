require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TaskMapper::Provider::Github::Ticket do
  before(:each) do
    @github = TaskMapper.new(:github, {:login => 'taskmapper-user', :password => 'Tm123456'})
    @project = @github.projects.first
    @ticket_id = 1
    @klass = TaskMapper::Provider::Github::Ticket

    # mocking requests
    stub_get('https://taskmapper-user:Tm123456@api.github.com/repos/taskmapper-user/tmtest-repo', 'project.json')
    stub_get('https://taskmapper-user:Tm123456@api.github.com/repos/taskmapper-user/tmtest-repo/issues', 'issues.json')
    stub_get('https://taskmapper-user:Tm123456@api.github.com/repos/taskmapper-user/tmtest-repo/issues?state=closed', 'closed_issues.json')
    stub_get('https://taskmapper-user:Tm123456@github.com/api/v2/json/issues/show/taskmapper-user/tmtest-repo/1', 'issues/1.json')
    stub_post('https://taskmapper-user:Tm123456@github.com/api/v2/json/issues/edit/taskmapper-user/tmtest-repo/1', 'issues/1.json')
    stub_post('https://taskmapper-user:Tm123456@github.com/api/v2/json/issues/open/taskmapper-user/tmtest-repo', 'issues/new_ticket.json')
  end

  it "should be able to load all tickets" do
    @tickets = @project.tickets
    @tickets.should be_an_instance_of(Array)
    @tickets.first.should be_an_instance_of(@klass)
  end

  it "should be able to load tickets from an array of ids" do
    @tickets = @project.tickets([@ticket_id])
    @tickets.should be_an_instance_of(Array)
    @tickets.first.should be_an_instance_of(@klass)
  end

  it "should be able to find tickets based on attributes" do
    @tickets = @project.tickets(:id => @ticket_id)
    @tickets.should be_an_instance_of(Array)
    @tickets.first.should be_an_instance_of(@klass)
  end

  it "should find a ticket by id(number)" do
    @ticket = @project.ticket(@ticket_id)
    @ticket.should be_an_instance_of(@klass)
    @ticket.title.should be_eql('for testing')
  end

  it "should create a ticket" do 
    ticket = @project.ticket!(:title => 'new ticket', :description => 'testing')
    ticket.should be_an_instance_of(@klass)
  end

end
