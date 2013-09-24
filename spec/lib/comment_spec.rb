require 'spec_helper'

describe TaskMapper::Provider::Github::Comment do
  let(:tm) { create_instance }
  let(:project) { tm.project 'tmtest-repo' }
  let(:ticket) { project.tickets.first }
  let(:comment_class) { TaskMapper::Provider::Github::Comment }

  it "should be able to load all comments" do
    comments = ticket.comments
    comments.should be_an_instance_of(Array)
    comments.first.should be_an_instance_of(comment_class)
    comments.first.body.should == "for testing"
  end

  it "should be able to create a new comment" do
    comment = ticket.comment!(:body => 'for testing')
    comment.should be_an_instance_of(comment_class)
    comment.body.should == 'for testing'
  end

  #see bug 116 tm-github: Bug Ticket#comments returning comments with weird text in the body
  it "should be able to load a ticket and clean comment body" do
    comments = ticket.comments.map(&:body).should == ["for testing", "test comment"]
  end

  pending "should be able to update comments" do
    comment = ticket.comments.first
    comment.body = "updated comment"
    comment.save.should be_true
  end
end
