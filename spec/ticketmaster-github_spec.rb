require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Github" do

  before(:each) do 
    @github = TicketMaster.new(:github, {:login => 'juanespinosa', :token => 'asdfghk'})
  end

  it "should be able to instantiate a new instance" do
    @github.should be_an_instance_of(TicketMaster)
    @github.should be_a_kind_of(TicketMaster::Provider::Github)
  end

  it "should implement the valid method" do 
    @github.valid?.should be_true
  end

  it "should show attempted authenticated if a token is present" do
    pending
    @github = TicketMaster.new(:github, {:login => 'juanespinosa', :token => 'asdfghk'})
    @github.authorize
    TicketMaster::Provider::Github.api.authenticated?.should be_true
  end

end
