require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Github::Ticket" do
  before(:all) do
    @project_name = "project_name"
    @ticket_id = "1"
    @github =  TicketMaster.new(:github, {:login => 'juanespinosa', :token => 'asdfghk'})
    @klass = TicketMaster::Provider::Github::Ticket
  end
  
  before(:each) do
    @project = Factory.build(:project)
    @ticket = Factory.build(:ticket)
    @tickets = [@ticket]
    @klass.stub!(:find_by_attributes).and_return(@tickets)
    @klass.stub!(:find_by_id).and_return(@ticket)
    @klass.stub!(:create).and_return(@ticket)
    #@project.stub!(:tickets).and_return(@tickets)
  end
  
  it "should be able to load all tickets" do
    @project.tickets.should be_an_instance_of(Array)
    @project.tickets.first.should be_an_instance_of(@klass)
  end
  
  it "should be able to load ticket from an array of ids" do
    @tickets = @project.tickets([@ticket_id])
    @tickets.should be_an_instance_of(Array)
    @tickets.first.should be_an_instance_of(@klass)
    @tickets.first.number.should == @ticket_id
  end
  
  it "should be able to find a single ticket based on number attribute" do
    @ticket = @project.tickets({:number => @ticket_id})
    @ticket.should be_an_instance_of(@klass)
  end
  
  it "should find a ticket by id(number)" do
    @project.tickets(@ticket_id).should be_an_instance_of(@klass)
  end
  
  it "should be able to apen a new ticket" do
    @project.ticket!({:body => "new ticket", :title => "New"}).should be_an_instance_of(@klass)
  end
  
  it "should be able to update a existing ticket" do
    a = TicketMaster::Provider::Github::Ticket.new
    a.stub!(:save).with('a').and_return(true)
  end
end