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
        self.new(project_id, TicketMaster::Provider::Github.api.issue("#{TicketMaster::Provider::Github.login}/#{project_id}", number))
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
        issues += TicketMaster::Provider::Github.api.issues("#{TicketMaster::Provider::Github.login}/#{project_id}")
        state = 'closed'
        issues += TicketMaster::Provider::Github.api.issues("#{TicketMaster::Provider::Github.login}/#{project_id}", state)
        issues.collect { |issue| Ticket.new(project_id, issue) }
      end

      def self.open(project_id, *options)
        body = options.first.delete(:body)
        title = options.first.delete(:title)
        TicketMaster::Provider::Github.api.create_issue("#{TicketMaster::Provider::Github.login}/#{project_id}", title, body, options.first)
      end

      def save
        t = Ticket.find_by_id(project_id, number)
        return false if t.title == title and t.body == body
        Ticket.new(project_id, TicketMaster::Provider::Github.api.update_issue("#{TicketMaster::Provider::Github.login}/#{project_id}", number, title, body))
        true
      end

      def reopen
        Ticket.new [project_id, TicketMaster::Provider::Github.api.reopen_issue("#{TicketMaster::Provider::Github.login}/#{project_id}", number)]
      end

    end
  end
end
