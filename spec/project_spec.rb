require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TaskMapper::Provider::Github::Project do

  let(:tm) {TaskMapper.new(:github, :login => 'taskmapper-user', :password => 'Tm123456')}
  let(:project_name) { 'tmtest-repo' }
  let(:returned_repo) { 'taskmapper-user/tmtest-repo' }
  let(:project_class) { TaskMapper::Provider::Github::Project }

  before(:all) do 
    @repo_name = "tmtest-repo"
    @returned_repo = "taskmapper-user/tmtest-repo"
    @klass = TaskMapper::Provider::Github::Project
  end

  before(:each) do
    @github = TaskMapper.new(:github, :login => 'taskmapper-user', :password => 'Tm123456')
  end

  describe "Retrieving projects" do 
    before(:each) do 
      stub_get('https://taskmapper-user:Tm123456@api.github.com/users/taskmapper-user/repos', 'projects.json')
      stub_get('https://taskmapper-user:Tm123456@api.github.com/repos/taskmapper-user/tmtest-repo', 'project.json')
    end

    context "when #projects" do 
      subject { tm.projects } 
      it { should be_an_instance_of Array }

      context "when #projects.first" do 
        subject { tm.projects.first } 
        it { should be_an_instance_of project_class }
      end
    end

    context "when #projects with id's" do 
      subject { tm.projects [project_name] }
      it { should be_an_instance_of Array }
    end

  end

  it "should be able to load a single project based on a single name(id)" do 
    pending
    @project = @github.projects(@repo_name)
    @project.should be_an_instance_of(@klass)
    @project.id.should == @returned_repo
  end

  it "should be able to find by name(id)" do
    pending
    @project = @github.project(@repo_name)
    @project.should be_an_instance_of(@klass)
    @project.id.should == @returned_repo
  end

  it "should be able to find by attributes" do
    pending
    @projects = @github.projects(:name => 'tmtest-repo')
    @projects.should be_an_instance_of(Array)
    @projects.first.id.should be_eql(@returned_repo)
  end
end

