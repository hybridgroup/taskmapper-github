require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Pivotal::Project" do

  before(:all) do
    @github =  TicketMaster.new(:Github, {:login => 'juanespinosa', :token => 'asdfghk'})
    @klass = TicketMaster::Provider::Github::Project
  end

  before(:each) do
    @project = Factory.build(:project)
    @projects = [@project]
    @github.stub!(:projects).and_return(@projects)
    @github.stub_chain(:projects, :find).with(an_instance_of(String)).and_return(@project)
    @github.stub_chain(:projects, :find).with(an_instance_of(Array)).and_return(@projects)
  end
  
  it "should be able to load all projects" do
    @github.projects.should be_an_instance_of(Array)
    @github.projects.first.should be_an_instance_of(@klass)
  end
  
  it "should be able to find by name(id)" do
    p = @github.projects.find("project name")
    p.should be_an_instance_of(@klass)
    p.name.should be_eql("project name")
  end
  
  it "should be able to get projects with array of names" do
    p = @github.projects.find(["project1"])
    p.should be_an_instance_of(Array)
    p.first.should be_an_instance_of(@klass)
  end
end

