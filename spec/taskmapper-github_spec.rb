require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "TaskMapper::Provider::Github" do

  before(:each) do 
    @github = TaskMapper.new(:github, :login => 'cored')
  end

  it "should be able to instantiate a new instance" do
    @github.should be_an_instance_of(TaskMapper)
    @github.should be_a_kind_of(TaskMapper::Provider::Github)
  end

  context 'when calling #valid?' do
    it 'should test #authenticated' do
      TaskMapper::Provider::Github.api.should_receive(:authenticated?).and_return true
      @github.valid?.should be_true
    end

    it 'should return false when the user provides wrong credentials' do
      TaskMapper::Provider::Github.api.should_receive(:authenticated?).and_return false
      @github.valid?.should_not be_true
    end
  end
end
