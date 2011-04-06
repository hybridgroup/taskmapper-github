require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Github::Ticket" do
  before(:each) do
    @github = TicketMaster.new(:github, {:login => 'jquery'})
    @project = @github.project('jquery-mobile')
    @ticket_id = 1
    @klass = TicketMaster::Provider::Github::Ticket
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
  
  it "should be able to find a single ticket based on number attribute" do
    pending
  end
  
  it "should find a ticket by id(number)" do
    pending
  end
  
  it "should be able to open a new ticket" do
    pending
  end
  
  it "should be able to update a existing ticket" do
    pending
  end
  
  it "should be able to close a ticket" do
    pending
  end

  it "should be able to reopen a ticket" do
    pending
  end
end
