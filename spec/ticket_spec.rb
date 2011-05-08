require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Github::Ticket" do
  before(:each) do
    @github = TicketMaster.new(:github, {:login => 'cored'})
    @project = @github.project('jquery/jquery-mobile')
    @ticket_id = 1
    @ticket = {:body => 'Creating a ticket from API', :title => 'Ticket for jquery', :number => 1}
    @klass = TicketMaster::Provider::Github::Ticket
    @api = Octokit::Client
  end
  
  it "should be able to load all tickets" do
    @project.tickets.should be_an_instance_of(Array) 
    @project.tickets.first.should be_an_instance_of(@klass)
  end

  it "should be able to load tickets from an array of ids" do
    tickets = @project.tickets([@ticket_id])
    tickets.should be_an_instance_of(Array)
    tickets.first.should be_an_instance_of(@klass)
  end

  it "should be able to find tickets based on attributes" do
    tickets = @project.tickets(:number => @ticket_id)
    tickets.should be_an_instance_of(Array)
    tickets.first.should be_an_instance_of(@klass)
  end

  it "should find a ticket by id(number)" do
    ticket = @project.ticket(@ticket_id)
    ticket.should be_an_instance_of(@klass)
    ticket.title.should be_eql('Move Ajax Test to Core')
  end

  it "should be able to open a new ticket" 

  it "should be able to update a existing ticket" 

  it "should be able to reopen a ticket" 

  it "should be able to close a ticket" 
end
