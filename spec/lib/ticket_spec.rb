require 'spec_helper'

describe TaskMapper::Provider::Github::Ticket do
  let(:tm) { create_instance }
  let(:ticket_id) { 1 }
  let(:ticket_class) { TaskMapper::Provider::Github::Ticket }
  let(:project) { tm.project 'tmtest-repo' }

  describe "Retrieving tickets" do
    context "when #tickets" do
      subject { project.tickets }
      it { should be_an_instance_of Array }
      it { should_not be_empty }

      context "when #tickets.first" do
        subject { project.tickets.first }
        it { should be_an_instance_of ticket_class }
      end
    end

    context "when #tickets with array of id's" do
      subject { project.tickets [ticket_id] }
      it { should be_an_instance_of Array }
      it { should_not be_empty }
    end

    context "when #tickets with attributes" do
      subject { project.tickets :id => ticket_id }
      it { should be_an_instance_of Array }
      it { should_not be_empty }
    end
  end

  describe "Create and Update" do
    context "when #ticket! with :title and :description" do
      subject { project.ticket!(:title => 'new ticket', :description => 'testing') }
      it { should be_an_instance_of ticket_class }
    end
  end
end
