require 'spec_helper'

describe "TaskMapper::Provider::tm" do
  let(:tm) { TaskMapper.new(:github, :login => 'cored') }
  subject { tm }

  context "when calling #valid? with valid credentials" do
    before { tm.should_receive(:valid?).and_return(true) }
    its(:valid?) { should be_true }
  end

  context "should return false when the user provides wrong credentials" do
    before { tm.should_receive(:valid?).and_return(false) }
    its(:valid?) { should be_false }
  end
end
