module TaskMapper::Provider
  module Github
    include TaskMapper::Provider::Base

    class << self
      attr_accessor :login, :api, :user_token
    end

    def self.new(auth = {})
      TaskMapper.new(:github, auth)
    end

    def provider
      TaskMapper::Provider::Github
    end

    def new_github_client(auth)
      Octokit::Client.new auth
    end

    def authorize(auth = {})
      @authentication ||= TaskMapper::Authenticator.new(auth)
      auth[:login] = auth.fetch(:login) || auth.fetch(:username)
      raise TaskMapper::Exception.new('Please provide at least a username') if auth[:login].blank?
      provider.login = auth[:login]
      provider.user_token = auth[:password] || auth[:token]
      provider.api = new_github_client auth
    end

    def valid?
      provider.api.authenticated? || provider.api.oauthed?
    end
  end
end
