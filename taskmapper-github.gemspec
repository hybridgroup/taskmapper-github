# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "taskmapper-github"
  s.version = "0.10.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["HybridGroup"]
  s.date = "2012-05-14"
  s.description = "This provides an interface with github through the taskmapper gem."
  s.email = "hong.quach@abigfisch.com"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    ".bundle/config",
    ".document",
    ".rbenv-gemsets",
    ".rbenv-version",
    ".travis.yml",
    "Gemfile",
    "Gemfile.lock",
    "Guardfile",
    "LICENSE",
    "README.md",
    "Rakefile",
    "VERSION",
    "lib/provider/comment.rb",
    "lib/provider/github.rb",
    "lib/provider/project.rb",
    "lib/provider/ticket.rb",
    "lib/taskmapper-github.rb",
    "spec/comment_spec.rb",
    "spec/fixtures/closed_issues.json",
    "spec/fixtures/comments.json",
    "spec/fixtures/comments/3951282.json",
    "spec/fixtures/comments/3951282_update.json",
    "spec/fixtures/issues.json",
    "spec/fixtures/issues/1.json",
    "spec/fixtures/issues/new_ticket.json",
    "spec/fixtures/project.json",
    "spec/fixtures/projects.json",
    "spec/fixtures/repositories.json",
    "spec/project_spec.rb",
    "spec/spec.opts",
    "spec/spec_helper.rb",
    "spec/taskmapper-github_spec.rb",
    "spec/ticket_spec.rb",
    "taskmapper-github.gemspec"
  ]
  s.homepage = "http://github.com/kiafaldorius/taskmapper-github"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.15"
  s.summary = "The github provider for taskmapper"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<taskmapper>, ["~> 0.8"])
      s.add_runtime_dependency(%q<octokit>, ["~> 0.6"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6"])
      s.add_development_dependency(%q<rspec>, ["~> 2.3"])
      s.add_development_dependency(%q<fakeweb>, ["~> 1.3"])
      s.add_development_dependency(%q<simplecov>, ["~> 0.5"])
      s.add_development_dependency(%q<rcov>, ["~> 1.0"])
    else
      s.add_dependency(%q<taskmapper>, ["~> 0.8"])
      s.add_dependency(%q<octokit>, ["~> 0.6"])
      s.add_dependency(%q<jeweler>, ["~> 1.6"])
      s.add_dependency(%q<rspec>, ["~> 2.3"])
      s.add_dependency(%q<fakeweb>, ["~> 1.3"])
      s.add_dependency(%q<simplecov>, ["~> 0.5"])
      s.add_dependency(%q<rcov>, ["~> 1.0"])
    end
  else
    s.add_dependency(%q<taskmapper>, ["~> 0.8"])
    s.add_dependency(%q<octokit>, ["~> 0.6"])
    s.add_dependency(%q<jeweler>, ["~> 1.6"])
    s.add_dependency(%q<rspec>, ["~> 2.3"])
    s.add_dependency(%q<fakeweb>, ["~> 1.3"])
    s.add_dependency(%q<simplecov>, ["~> 0.5"])
    s.add_dependency(%q<rcov>, ["~> 1.0"])
  end
end
