require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Github::Project" do

  before(:all) do
    @repo_name = "jquery-mobile"
    @klass = TicketMaster::Provider::Github::Project
  end

  before(:each) do
    @github =  TicketMaster.new(:github, {:login => 'jquery'})
  end
  
  it "should be able to load all projects" do
    pending
  end
  
  it "should be able to find by name(id)" do
    pending
  end
  
  it "should be able to find by name(id) with find method" do
    pending
  end
  
  it "should be able to get projects with array of names" do
    pending
  end
  
  it "should be able to find by attributes(name and repo)" do
    pending
  end
  
  it "should be able to find repos in an array" do
    pending
  end
end

