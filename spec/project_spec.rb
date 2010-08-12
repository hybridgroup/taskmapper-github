require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Github::Project" do

  before(:all) do
    @repo_name = "project_name"
    @klass = TicketMaster::Provider::Github::Project
  end

  before(:each) do
    @repository = Factory.build(:repository)
    @repositories = [@repository]
    @github =  TicketMaster.new(:github, {:login => 'juanespinosa', :token => 'asdfghk'})
  end
  
  it "should be able to load all projects" do
    Octopi::Repository.stub!(:find).and_return(@repositories)
    projects = @github.projects
    projects.should be_an_instance_of(Array)
    projects.first.should be_an_instance_of(@klass)
  end
  
  it "should be able to find by name(id)" do
    Octopi::Repository.stub!(:find).and_return(@repository)
    p = @github.project(@repo_name)
    p.should be_an_instance_of(@klass)
    p.name.should be_eql(@repo_name)
  end
  
  it "should be able to find by name(id) with find method" do
    Octopi::Repository.stub!(:find).and_return(@repository)
    p = @github.project.find(@repo_name)
    p.should be_an_instance_of(@klass)
    p.name.should be_eql(@repo_name)
  end
  
  it "should be able to get projects with array of names" do
    Octopi::Repository.stub!(:find).and_return(@repository)
    p = @github.projects([@repo_name])
    p.should be_an_instance_of(Array)
    p.first.should be_an_instance_of(@klass)
  end
  
  it "should be able to find by attributes(name and repo)" do
    Octopi::Repository.stub!(:find).and_return(@repository)
    p = @github.project.find(:first, {:user => 'juanespinosa', :repo => 'test-juange'})
    p.should be_an_instance_of(@klass)
  end
  
  it "should be able to find repos in an array" do
    Octopi::Repository.stub!(:find_all).and_return(@repositories)
    p = @github.project.find(:all, ['test-juange', 'ticketmaster'])
    p.should be_an_instance_of(Array)
  end
end

