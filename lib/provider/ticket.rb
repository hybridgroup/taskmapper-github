module TicketMaster::Provider
  module Github
    # Ticket class for ticketmaster-github
    
    class Ticket < TicketMaster::Provider::Base::Ticket
      
      @@allowed_states = %w{open close}
      attr_accessor :prefix_options
      # declare needed overloaded methods here
      
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

      def author
        self.user.respond_to?('login') ? self.user.login : self.user
      end

      def requestor
        self.user.respond_to?('login') ? self.user.login : self.user
      end

      def assignee
        self.user.respond_to?('login') ? self.user.login : self.user
      end

      def self.find_by_id(project_id, number) 
        issue = TicketMaster::Provider::Github.api.issue(project_id, number)
        issue.merge!(:project_id => project_id)
        self.new issue
      end

      def self.find(project_id, *options)
        if options[0].empty?
          self.find_all(project_id)
        elsif options[0].first.is_a? Array
          options[0].first.collect { |number| self.find_by_id(project_id, number) }
        elsif options[0].first.is_a? Hash
          self.find_by_attributes(project_id, options[0].first)
        end
      end

      def self.find_by_attributes(project_id, attributes = {})
        issues = self.find_all(project_id)
        search_by_attribute(issues, attributes)
      end

      def self.find_all(project_id)
        issues = []
        issues += TicketMaster::Provider::Github.api.issues(project_id)
        issues += TicketMaster::Provider::Github.api.issues(project_id, {:state => "closed"})
        issues.collect do |issue| 
          issue.merge!(:project_id => project_id)
          Ticket.new issue
        end
      end

      def self.open(project_id, *options)
        body = options.first.delete(:body)
        title = options.first.delete(:title)
        new_issue = TicketMaster::Provider::Github.api.create_issue(project_id, title, body, options.first)
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
        issue = Ticket.find_by_id(project_id, number)
        return false if issue.title == title and issue.body == body
        ticket_update = TicketMaster::Provider::Github.api.update_issue(project_id, number, title, body)
        ticket_update.merge!(:project_id => project_id)
        Ticket.new ticket_update
        true
      end

      def reopen
        Ticket.new(project_id, TicketMaster::Provider::Github.api.reopen_issue(project_id, number))
      end

      def close
        Ticket.new(project_id, TicketMaster::Provider::Github.api.close_issue(project_id, number)) 
      end

      def comment!(attributes)
        Comment.create(project_id, number, attributes)
      end
    end
  end
end
