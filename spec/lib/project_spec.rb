require 'spec_helper'

describe TaskMapper::Provider::Github::Project do
  let(:tm) { create_instance }
  let(:project_name) { 'tmtest-repo' }
  let(:returned_repo) { 'taskmapper-user/tmtest-repo' }
  let(:project_class) { TaskMapper::Provider::Github::Project }

  describe "#projects" do
    context "with no arguments" do
      let(:projects) { tm.projects }

      it "returns an array of all projects" do
        expect(projects).to be_an Array
        expect(projects.first).to be_a project_class
      end
    end

    context "with an array of project names" do
      let(:projects) { tm.projects [project_name] }

      it "returns an array of matching projects" do
        expect(projects).to be_an Array
        expect(projects.length).to eq 1
        expect(projects.first).to be_a project_class
        expect(projects.first.name).to eq project_name
      end
    end

    context "with a hash containing a project name" do
      let(:projects) { tm.projects :name => project_name }

      it "returns an array containing the matching project" do
        expect(projects).to be_an Array
        expect(projects.length).to eq 1
        expect(projects.first).to be_a project_class
        expect(projects.first.name).to eq project_name
      end
    end
  end

  describe "#project" do
    context "with a project name" do
      let(:project) { tm.project project_name }

      it "returns the matching project" do
        expect(project).to be_a project_class
        expect(project.name).to eq project_name
      end
    end

    context "with a hash containing a project name" do
      let(:project) { tm.project :name => project_name }
      it "returns the matching project" do
        expect(project).to be_a project_class
        expect(project.name).to eq project_name
      end
    end
  end
end
