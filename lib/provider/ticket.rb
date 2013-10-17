module TaskMapper::Provider
  module Github
    class Ticket < TaskMapper::Provider::Base::Ticket
      def initialize(*object)
        object = object.first if object.is_a?(Array)
        super object
      end

      def id
        self.number
      end

      def status
        self.state
      end

      def description
        self.body
      end

      def description=(val)
        self.body = val
      end

      def author
        github_user
      end

      def requestor
        github_user
      end

      def assignee
        github_user
      end

      def self.find_by_id(project_id, issue_id)
        issue = api.issue(project_id, issue_id).attrs[:issue].attrs
        issue.merge!(:project_id => project_id)
        self.new issue
      end

      def self.find_by_attributes(project_id, attributes = {})
        issues = self.find_all(project_id)
        search_by_attribute(issues, attributes)
      end

      def self.find_all(project_id)
        issues = Array(api.issues(project_id))
        issues += api.issues(project_id, :state => "closed") unless issues.empty?
        issues.collect { |i| self.new i.attrs.merge(:project_id => project_id) }
      end

      def self.open(project_id, *options)
        ticket_hash = options.first
        body = ticket_hash.delete(:description)
        title = ticket_hash.delete(:title)
        new_issue = api.create_issue(project_id, title, body, options.first)
        new new_issue.attrs[:issue].attrs.merge(:project_id => project_id)
      end

      def created_at
        Time.parse(self[:created_at])
      rescue
        self[:created_at]
      end

      def updated_at
        Time.parse(self[:updated_at])
      rescue
        self[:updated_at]
      end

      def save
        api.update_issue(project_id, number, title, description)
        true
      end

      def reopen
        self.state = 'open'
        api.reopen_issue(project_id, number)
      end

      def close
        self.state = 'closed'
        api.close_issue(project_id, number)
      end

      def comment!(attributes)
        Comment.create(project_id, number, attributes)
      end

      private
      def github_user
        self.user.login || self.user
      end

      def self.api
        TaskMapper::Provider::Github.api
      end

      def api
        self.class.api
      end
    end
  end
end
