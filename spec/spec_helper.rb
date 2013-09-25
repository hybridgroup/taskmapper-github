require 'taskmapper-github'
require 'rspec'
require 'fakeweb'

FakeWeb.allow_net_connect = false

def fixture_file(filename)
  return '' if filename == ''
  file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename)
  File.read(file_path)
end

def stub_request(method, url, filename, status=nil)
  options = {:body => ""}
  options.merge!({:body => fixture_file(filename)}) if filename
  options.merge!({:body => status.last}) if status
  options.merge!({:status => status}) if status
  options.merge!({:content_type => 'application/json'})

  FakeWeb.register_uri(method, url, options)
end

def stub_get(*args); stub_request(:get, *args) end
def stub_post(*args); stub_request(:post, *args) end
def stub_put(*args); stub_request(:put, *args) end
def stub_patch(*args); stub_request(:patch, *args) end
def stub_delete(*args); stub_request(:delete, *args) end

def create_instance(login = 'taskmapper-user', password = 'Tm123456')
  TaskMapper.new :github, :login => login, :password => password
end

RSpec.configure do |c|
  c.before do
    stub_get(
      'https://taskmapper-user:Tm123456@api.github.com/orgs/2hf/repos',

      'org_repos.json'
    )
    stub_get(
      'https://taskmapper-user:Tm123456@api.github.com/repos/taskmapper-user/tmtest-repo',
      'project.json'
    )
    stub_get(
      'https://taskmapper-user:Tm123456@api.github.com/repos/taskmapper-user/tmtest-repo/issues',
      'issues.json'
    )
    stub_get(
      'https://taskmapper-user:Tm123456@api.github.com/repos/taskmapper-user/tmtest-repo/issues/1',
      'issues/1.json'
    )
    stub_get(
      'https://taskmapper-user:Tm123456@api.github.com/repos/taskmapper-user/tmtest-repo/issues/1/comments',
      'comments.json'
    )
    stub_get(
      'https://taskmapper-user:Tm123456@api.github.com/repos/taskmapper-user/tmtest-repo/issues?state=closed',
      'closed_issues.json'
    )
    stub_get(
      'https://taskmapper-user:Tm123456@api.github.com/repos/taskmapper-user/tmtest-repo/issues?state=closed',
      'issues.json'
    )
    stub_get(
      'https://taskmapper-user:Tm123456@api.github.com/repos/taskmapper-user/tmtest-repo/issues?state=open',
      'issues.json'
    )
    stub_get(
      'https://taskmapper-user:Tm123456@api.github.com/users/taskmapper-user/orgs',
      'organizations.json'
    )
    stub_get(
      'https://taskmapper-user:Tm123456@api.github.com/users/taskmapper-user/repos',
      'projects.json'
    )
    stub_get(
      'https://taskmapper-user:Tm123456@github.com/api/v2/json/organizations/repositories',
      'repositories.json'
    )
    stub_post(
      'https://taskmapper-user:Tm123456@api.github.com/repos/taskmapper-user/tmtest-repo/issues/1/comments',
      'comments/3951282.json'
    )
    stub_patch(
      'https://taskmapper-user:Tm123456@api.github.com/repos/taskmapper-user/tmtest-repo/issues/comments/3951282',
      'comments/3951282_update.json'
    )
    stub_post(
      'https://taskmapper-user:Tm123456@api.github.com/repos/taskmapper-user/tmtest-repo/issues',
      'issues/1.json'
    )
  end
end
