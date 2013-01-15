require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TaskMapper::Provider::Github::Ticket do
  
  let(:tm) { TaskMapper.new(:github, {:login => 'taskmapper-user', :password => 'Tm123456'}) }
  let(:ticket_id) { 1 }
  let(:ticket_class) { TaskMapper::Provider::Github::Ticket }
  let(:project) { tm.project 'tmtest-repo' }

  describe "Retrieving tickets" do 
    before(:each) do 
      stub_get('https://taskmapper-user:Tm123456@api.github.com/orgs/2hf/repos?since', 'org_repos.json')
      stub_get('https://taskmapper-user:Tm123456@api.github.com/repos/taskmapper-user/tmtest-repo/issues/1', 'issues/1.json')
      stub_get('https://taskmapper-user:Tm123456@api.github.com/repos/taskmapper-user/tmtest-repo/issues', 'issues.json')
      stub_get('https://taskmapper-user:Tm123456@api.github.com/repos/taskmapper-user/tmtest-repo/issues?state=closed', 'issues.json')
      stub_get('https://taskmapper-user:Tm123456@api.github.com/repos/taskmapper-user/tmtest-repo/issues?state=open', 'issues.json')
    end
    
    context "when #tickets" do 
      subject { project.tickets } 
      it { should be_an_instance_of Array }
      it { should_not be_empty }
      
      context "when #tickets.first" do 
        subject { project.tickets.first } 
        it { should be_an_instance_of ticket_class }
      end
    end 

    context "when #tickets with array of id's" do 
      subject { project.tickets [ticket_id] }
      it { should be_an_instance_of Array }
      it { should_not be_empty }
    end

    context "when #tickets with attributes" do 
      subject { project.tickets :id => ticket_id }
      it { should be_an_instance_of Array }
      it { should_not be_empty }
    end
  end

  describe "Create and Update" do 
    before(:each) do 
      stub_post('https://taskmapper-user:Tm123456@api.github.com/repos/taskmapper-user/tmtest-repo/issues', 'issues/1.json')
    end

    context "when #ticket! with :title and :description" do 
      subject { project.ticket!(:title => 'new ticket', :description => 'testing') }
      it { should be_an_instance_of ticket_class }
    end
  end

end
