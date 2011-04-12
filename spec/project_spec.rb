require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Github::Project" do

  before(:all) do
    @repo_name = "flying_robot"
    @klass = TicketMaster::Provider::Github::Project
  end

  before(:each) do
    @github =  TicketMaster.new(:github, {:login => 'deadprogrammer' })
  end
  
  it "should be able to load all projects" do
    @github.projects.should be_an_instance_of(Array)
    @github.projects.first.should be_an_instance_of(@klass)
  end

  it "should be able to load all projects based on an array of name(id)" do 
    projects = @github.projects([@repo_name])
    projects.should be_an_instance_of(Array)
    projects.first.should be_an_instance_of(@klass)
    projects.first.name.should == @repo_name
  end

  it "should be able to find by name(id)" do
    p = @github.project(@repo_name)
    p.should be_an_instance_of(@klass)
    p.name.should be_eql(@repo_name)
  end

  it "should be able to find by name(id) with the find method" do 
    p = @github.project.find(@repo_name)
    p.should be_an_instance_of(@klass)
    p.name.should be_eql(@repo_name)
  end
  
  it "should be able to find by attributes" do
    projects = @github.projects(:name => @repo_name)
    projects.should be_an_instance_of(Array)
    projects.first.name.should be_eql(@repo_name)
  end
end

