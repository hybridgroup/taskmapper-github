require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Github::Project" do

  before(:all) do 
    @repo_name = "tmtest-repo"
    @returned_repo = "ticketmaster-user/tmtest-repo"
    @klass = TicketMaster::Provider::Github::Project
  end

  before(:each) do
    @github = TicketMaster.new(:github, :login => 'ticketmaster-user', :password => 'Tm123456')
  end

  it "should be able to load all projects" do
    stub_get('https://ticketmaster-user:Tm123456@api.github.com/users/ticketmaster-user/repos', 'projects.json')
    @projects = @github.projects
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

  it "should be able to find by attributes" do
    pending
    VCR.use_cassette('github-project-find-attributes') { @projects = @github.projects(:name => 'tmtest-repo') }
    @projects.should be_an_instance_of(Array)
    @projects.first.id.should be_eql(@returned_repo)
  end
end

