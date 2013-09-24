require 'spec_helper'

describe TaskMapper::Provider::Github::Project do
  let(:tm) {TaskMapper.new(:github, :login => 'taskmapper-user', :password => 'Tm123456')}
  let(:project_name) { 'tmtest-repo' }
  let(:returned_repo) { 'taskmapper-user/tmtest-repo' }
  let(:project_class) { TaskMapper::Provider::Github::Project }

  describe "Retrieving projects" do
    before(:each) do
      stub_get('https://taskmapper-user:Tm123456@api.github.com/users/taskmapper-user/repos', 'projects.json')
      stub_get('https://taskmapper-user:Tm123456@api.github.com/repos/taskmapper-user/tmtest-repo', 'project.json')
      stub_get('https://taskmapper-user:Tm123456@api.github.com/users/taskmapper-user/orgs', 'organizations.json')
      stub_get('https://taskmapper-user:Tm123456@api.github.com/orgs/2hf/repos', 'org_repos.json')
    end

    context "when #projects" do
      subject { tm.projects }
      it { should be_an_instance_of Array }

      context "when #projects.first" do
        subject { tm.projects.first }
        it { should be_an_instance_of project_class }
      end
    end

    pending "when #projects with id's" do
      subject { tm.projects [project_name] }
      it { should be_an_instance_of Array }
    end

    pending "when #projects with attributes" do
      subject { tm.projects :name =>  project_name }
      it { should be_an_instance_of Array }
    end

    pending "Retrieve a single project" do
      context "when #project with name" do
        subject { tm.project project_name }
        it { should be_an_instance_of project_class }
      end

      context "when #project with attribute" do
        subject { tm.project :name => project_name }
        it { should be_an_instance_of project_class }
      end
    end
  end
end

