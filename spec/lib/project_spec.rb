require 'spec_helper'

describe TaskMapper::Provider::Github::Project do
  let(:tm) { create_instance }
  let(:project_name) { 'tmtest-repo' }
  let(:returned_repo) { 'taskmapper-user/tmtest-repo' }
  let(:project_class) { TaskMapper::Provider::Github::Project }

  describe "Retrieving projects" do
    context "when #projects" do
      subject { tm.projects }
      it { should be_an_instance_of Array }

      context "when #projects.first" do
        subject { tm.projects.first }
        it { should be_an_instance_of project_class }
      end
    end

    describe "when #projects with id's" do
      subject { tm.projects [project_name] }
      it { should be_an_instance_of Array }
    end

    describe "when #projects with attributes" do
      subject { tm.projects :name =>  project_name }
      it { should be_an_instance_of Array }
    end

    describe "Retrieve a single project" do
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
