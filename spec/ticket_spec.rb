require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Github::Ticket" do
  before(:all) do
    @github =  TicketMaster.new(:github, {:login => 'juanespinosa', :token => 'asdfghk'})
    @klass = TicketMaster::Provider::Github::Ticket
#    @api = Octopi::Issue
  end
  
  before(:each) do
    @ticket_id = "1"
#    @project = TicketMaster::Provider::Github::Project.new Factory.build(:repository)
#    @ticket = Factory.build(:issue)
#    @tickets = [@ticket]
#    @ticket.stub_chain(:repository, :name).and_return(@ticket.repository)
  end
  
  it "should be able to load all tickets" do
#    @api.stub!(:find_all).and_return(@tickets)
    tickets = @project.tickets
    tickets.should be_an_instance_of(Array)
    tickets.first.should be_an_instance_of(@klass)
  end
  
  it "should be able to load ticket from an array of ids" do
#    @api.stub!(:find).and_return(@ticket)
    @tickets = @project.tickets([@ticket_id])
    @tickets.should be_an_instance_of(Array)
    @tickets.first.should be_an_instance_of(@klass)
    @tickets.first.number.should == @ticket_id
  end
  
  it "should be able to find a single ticket based on number attribute" do
#    @api.stub!(:find).and_return(@ticket)
    @ticket = @project.tickets({:number => @ticket_id})
    @ticket.should be_an_instance_of(@klass)
  end
  
  it "should find a ticket by id(number)" do
#    @api.stub!(:find).and_return(@ticket)
    @project.tickets(@ticket_id).should be_an_instance_of(@klass)
  end
  
  it "should be able to open a new ticket" do
#    @api.stub!(:open).and_return(@ticket)
    tick = @project.ticket!({:body => "new ticket", :title => "New"})
    tick.should be_an_instance_of(@klass)
  end
  
  it "should be able to update a existing ticket" do
#    @ticket.stub!(:save).and_return(true)
    @ticket.body = "new ticket body"
    @ticket.save.should be_eql(true)
  end
  
  it "should be able to close a ticket" do
#    @api.stub_chain(:find, :close!).and_return(@ticket)
    @klass.new.close.should be_an_instance_of(@klass)
  end

  it "should be able to reopen a ticket" do
#    @api.stub_chain(:find, :reopen!).and_return(@ticket)
    @klass.new.reopen.should be_an_instance_of(@klass)
  end
end
