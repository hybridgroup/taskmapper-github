require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Github" do

  it "Should be able to instantiate a new instance" do
    @github =  TicketMaster.new(:Github, {:login => 'juanespinosa', :token => 'asdfghk'})
    @github.should be_an_instance_of(TicketMaster)
    @github.should be_a_kind_of(TicketMaster::Provider::Github)
  end

end
