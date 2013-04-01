module TaskMapper::Provider::Github
  class OctokitWrapper

    def initialize(username, password)
      @username = username
      @password = password
      @octokit = Octokit::Client.new(:login => @username, :password => @password)
    end

    def valid?
    end
  end
end
