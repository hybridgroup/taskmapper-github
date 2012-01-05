require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Github::Project" do

  before(:all) do 
    @repo_name = "translate"
    @returned_repo = "/flying_robot"
    @klass = TicketMaster::Provider::Github::Project
  end

  before(:each) do
    VCR.use_cassette('provider') { @github = TicketMaster.new(:github, :login => 'cored') }
  end

  it "should be able to load all projects" do
    pending
    VCR.use_cassette('github-projects') { @projects = @github.projects }
    @projects.should be_an_instance_of(Array)
    @projects.first.should be_an_instance_of(@klass)
  end

  it "should be able to load all projects based on an array of name(id)" do 
    pending
    VCR.use_cassette('github-projects-by-id') { @projects = @github.projects([@repo_name]) }
    @projects.should be_an_instance_of(Array)
    @projects.first.should be_an_instance_of(@klass)
    @projects.first.id.should == @returned_repo
  end

  it "should be able to load a single project based on a single name(id)" do 
    pending
    VCR.use_cassette('github-project-by-id') { @project = @github.projects(@repo_name) }
    @project.should be_an_instance_of(@klass)
    @project.id.should == @returned_repo
  end

  it "should be able to find by name(id)" do
    pending
    VCR.use_cassette('github-project-by-name') { @p = @github.project(@repo_name) }
    @p.should be_an_instance_of(@klass)
    @p.id.should == @returned_repo
  end

  it "should be able to find by name(id) with the find method" do 
    pending
    VCR.use_cassette('github-project-with-find') { @p = @github.project.find(@repo_name) }
    @p.should be_an_instance_of(@klass)
    @p.id.should be_eql(@returned_repo)
  end

  it "should be able to find by attributes" do
    pending
    VCR.use_cassette('github-project-find-attributes') { @projects = @github.projects(:name => 'translator') }
    @projects.should be_an_instance_of(Array)
    @projects.first.id.should be_eql('/translator')
  end
end

