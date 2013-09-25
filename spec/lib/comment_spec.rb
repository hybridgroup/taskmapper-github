require 'spec_helper'

describe TaskMapper::Provider::Github::Ticket do
  let(:tm) { create_instance }
  let(:project) { tm.project 'tmtest-repo' }
  let(:ticket) { project.tickets.first }
  let(:comment_class) { TaskMapper::Provider::Github::Comment }

  describe "#comments" do
    let(:comments) { ticket.comments }

    it "should return an array of all comments" do
      expect(comments).to be_an Array
      expect(comments.first).to be_a comment_class
    end

    it "cleans the comment bodies" do
      expect(comments.first.body).to eq "for testing"
      expect(comments.last.body).to eq "test comment"
    end

    it "can be updated" do
      comment = comments.first
      comment.body = "updated comment"
      expect(comment.save).to be_true
      expect(comment.body).to eq "updated comment"
    end
  end

  describe "#comment!" do
    context "with a comment body" do
      let(:comment) { ticket.comment! :body => "for testing" }

      it "creates a new comment" do
        expect(comment).to be_a comment_class
        expect(comment.body).to eq "for testing"
      end
    end
  end
end
