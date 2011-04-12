module TicketMaster::Provider
  module Github
    # Ticket class for ticketmaster-github
    
    class Ticket < TicketMaster::Provider::Base::Ticket
      
      @@allowed_states = %w{open close}
      attr_accessor :prefix_options
      # declare needed overloaded methods here
      
      def initialize(*object) 
        project_id = object.shift
        if object.first
          object = object.first
          @system_data = {:client => object} 
          unless object.is_a? Hash
            hash = {:title => object.title,
                    :created_at => object.created_at,
                    :updated_at => object.updated_at,
                    :number => object.number,
                    :user => object.user,
                    :id => object.number,
                    :state => object.state,
                    :html_url => object.html_url,
                    :position => object.position,
                    :description => object.body,
                    :project_id => project_id}
          else 
            object.merge!(:project_id => project_id)
            hash = object
          end 
          super hash
        end
      end

      def id
        self[:number]
      end

      def self.find_by_id(project_id, number) 
        self.new(project_id, TicketMaster::Provider::Github.api.issue(project_id, number))
      end

      def self.find(project_id, *options)
        if options.first.empty?
          self.find_all(project_id)
        elsif options[0].first.is_a? Array
          options.first.collect { |number| self.find_by_id(project_id, number) }
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
        state = 'closed'
        issues += TicketMaster::Provider::Github.api.issues(project_id, state)
        issues.collect { |issue| Ticket.new(project_id, issue) }
      end

      def self.open(project_id, *options)
        body = options.first.delete(:body)
        title = options.first.delete(:title)
        TicketMaster::Provider::Github.api.create_issue(project_id, title, body, options.first)
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
        t = Ticket.find_by_id(project_id, number)
        return false if t.title == title and t.body == body
        Ticket.new(project_id, TicketMaster::Provider::Github.api.update_issue(project_id, number, title, body))
        true
      end

      def reopen
        Ticket.new(project_id, TicketMaster::Provider::Github.api.reopen_issue(project_id, number))
      end

      def close
        Ticket.new(project_id, TicketMaster::Provider::Github.api.close_issue(project_id, number)) 
      end

      def comments
        Comment.find(project_id, number) 
      end

      def comment!(comment)
        Comment.create(project_id, number, comment)
      end

    end
  end
end
