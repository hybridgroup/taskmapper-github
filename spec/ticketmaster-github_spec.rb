require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Github" do

  before(:each) do 
    @github = TicketMaster.new(:github, :login => 'cored')
  end

  it "should be able to instantiate a new instance" do
    @github.should be_an_instance_of(TicketMaster)
    @github.should be_a_kind_of(TicketMaster::Provider::Github)
  end

  it "should show attempted authenticated if a token is present" do
    pending
    @github = TicketMaster.new(:github, {:login => 'juanespinosa', :token => 'asdfghk'})
    @github.authorize
    TicketMaster::Provider::Github.api.authenticated?.should be_true
  end

  context 'when calling #valid?' do
    it 'should test #total_private_repos number' do
      user = mock 'user'
      user.should_receive(:total_private_repos).and_return 0
      TicketMaster::Provider::Github.api.should_receive(:user).and_return user
      @github.valid?.should be_true
    end

    it 'should return false when the user provides wrong credentials' do
      TicketMaster::Provider::Github.api.should_receive(:user).
        and_raise 'some error'
      @github.valid?.should_not be_true
    end
  end
end
