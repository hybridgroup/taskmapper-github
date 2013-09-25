require 'spec_helper'

describe TaskMapper::Provider::Github::Project do
  let(:tm) { create_instance }
  let(:project) { tm.project 'tmtest-repo' }
  let(:ticket_id) { 1 }
  let(:ticket_class) { TaskMapper::Provider::Github::Ticket }

  describe "#tickets" do
    describe "with no arguments" do
      let(:tickets) { project.tickets }

      it "returns an array containing all tickets" do
        expect(tickets).to be_an Array
        expect(tickets.first).to be_a ticket_class
      end
    end

    describe "with an array of ticket IDs" do
      let(:tickets) { project.tickets [ticket_id] }

      it "returns an array of matching tickets" do
        expect(tickets).to be_an Array
        expect(tickets.length).to eq 1
        expect(tickets.first).to be_a ticket_class
        expect(tickets.first.id).to eq ticket_id
      end
    end

    describe "with a hash containing a ticket ID" do
      let(:tickets) { project.tickets :id => ticket_id }

      it "returns an array with the matching ticket" do
        expect(tickets).to be_an Array
        expect(tickets.first).to be_a ticket_class
        expect(tickets.first.id).to eq ticket_id
      end
    end
  end

  describe "#ticket!" do
    context "with a title and description" do
      let(:ticket) do
        project.ticket!(
          :title => "New Ticket",
          :description => "testing"
        )
      end

      it "creates a new ticket" do
        expect(ticket).to be_a ticket_class
        expect(ticket.title).to eq "New Ticket"
      end
    end
  end
end
