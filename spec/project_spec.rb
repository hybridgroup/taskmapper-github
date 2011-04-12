require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Github::Project" do

  before(:each) do
    @repo_name = "deadprogrammer/flying_robot"
    @klass = TicketMaster::Provider::Github::Project
    @github = TicketMaster.new(:github, {:login => 'cored'})
  end

  it "should be able to load all projects" do
    pending("get loading of projects working") do 
      @github.projects.should be_an_instance_of(Array)
      @github.projects.first.should be_an_instance_of(@klass)
    end
  end

  it "should be able to load all projects based on an array of name(id)" do 
    projects = @github.projects([@repo_name])
    projects.should be_an_instance_of(Array)
    projects.first.should be_an_instance_of(@klass)
    projects.first.id.should == @repo_name
  end

  it "should be able to load a single project based on a single name(id)" do 
    project = @github.projects(@repo_name)
    project.should be_an_instance_of(@klass)
    project.id.should be_eql(@repo_name)
  end

  it "should be able to find by name(id)" do
    p = @github.project(@repo_name)
    p.should be_an_instance_of(@klass)
    p.id.should be_eql(@repo_name)
  end

  it "should be able to find by name(id) with the find method" do 
    p = @github.project.find(@repo_name)
    p.should be_an_instance_of(@klass)
    p.id.should be_eql(@repo_name)
  end

  it "should be able to find by attributes" do
    pending('get find by attributes working') do 
      projects = @github.projects(:name => 'translator')
      projects.should be_an_instance_of(Array)
      projects.first.id.should be_eql('cored/translator')
    end
  end
end

