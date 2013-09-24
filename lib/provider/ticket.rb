module TaskMapper::Provider
  module Github
    class Ticket < TaskMapper::Provider::Base::Ticket
      def initialize(*object)
        if object.first
          object = object.first
          unless object.is_a? Hash
            hash = {:id => object.number,
              :status => object.state,
              :description => object.body,
              :user => object.user,
              :project_id => object.project_id}
          else
            hash = object
          end
          super hash
        end
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

      def self.find_by_id(project_id, number)
        issue = TaskMapper::Provider::Github.api.issue(project_id, number)
        issue.merge!(:project_id => project_id)
        self.new issue
      end

      def self.find_by_attributes(project_id, attributes = {})
        issues = self.find_all(project_id)
        search_by_attribute(issues, attributes)
      end

      def self.find_all(project_id)
        issues = []
        issues = Array(TaskMapper::Provider::Github.api.issues(project_id))
        issues += TaskMapper::Provider::Github.api.issues(project_id, {:state => "closed"}) unless issues.empty?
        issues.collect do |issue|
          issue.merge!(:project_id => project_id)
          Ticket.new issue
        end
      end

      def self.open(project_id, *options)
        ticket_hash = options.first
        body = ticket_hash.delete(:description)
        title = ticket_hash.delete(:title)
        new_issue = TaskMapper::Provider::Github.api.create_issue(project_id, title, body, options.first)
        new_issue.merge!(:project_id => project_id)
        self.new new_issue
      end

      def created_at
        begin
          Time.parse(self[:created_at])
        rescue
          self[:created_at]
        end
      end

      def updated_at
        begin
          Time.parse(self[:updated_at])
        rescue
          self[:updated_at]
        end
      end

      def save
        TaskMapper::Provider::Github.api.update_issue(project_id, number, title, description)
        true
      end

      def reopen
        Ticket.new(project_id, TaskMapper::Provider::Github.api.reopen_issue(project_id, number))
      end

      def close
        Ticket.new(project_id, TaskMapper::Provider::Github.api.close_issue(project_id, number))
      end

      def comment!(attributes)
        Comment.create(project_id, number, attributes)
      end

      private
      def github_user
        self.user.login || self.user
      end
    end
  end
end
