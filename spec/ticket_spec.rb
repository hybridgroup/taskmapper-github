require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Github::Ticket" do
  before(:each) do
    @github = TicketMaster.new(:github, {:login => 'ticketmaster-user', :password => 'Tm123456'})
    @project = @github.project('tmtest-repo')
    @ticket_id = 1
    @klass = TicketMaster::Provider::Github::Ticket

    # mocking requests
    stub_get('https://ticketmaster-user:Tm123456@api.github.com/repos/ticketmaster-user/tmtest-repo', 'project.json')
    stub_get('https://ticketmaster-user:Tm123456@api.github.com/repos/ticketmaster-user/tmtest-repo/issues', 'issues.json')
    stub_get('https://ticketmaster-user:Tm123456@api.github.com/repos/ticketmaster-user/tmtest-repo/issues?state=closed', 'closed_issues.json')
    stub_get('https://ticketmaster-user:Tm123456@github.com/api/v2/json/issues/show/ticketmaster-user/tmtest-repo/1', 'issues/1.json')
    stub_post('https://ticketmaster-user:Tm123456@github.com/api/v2/json/issues/edit/ticketmaster-user/tmtest-repo/1', 'issues/1.json')
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

  it "should update a ticket" do 
    @ticket = @project.ticket(@ticket_id)
    @ticket.save.should be_false
    @ticket.title = "Testing"
    @ticket.save.should be_true
  end

end
