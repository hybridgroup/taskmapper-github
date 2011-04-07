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
            @system_data = {:client => object} 
            hash = {:title => object.title,
                    :created_at => object.created_at,
                    :number => object.number,
                    :id => object.number,
                    :html_url => object.html_url,
                    :position => object.position,
                    :description => object.body,
                    :project_id => object.project_id}
          else 
            hash = object
          end 
          super hash
        end
      end

      def id
        self[:number]
      end

      def self.find_by_id(project_id, number) 
        self.new TicketMaster::Provider::Github.api.issue("#{TicketMaster::Provider::Github.login}/#{project_id}", number)
      end

      def self.find(project_id, *options)
        if options.first.empty?
          self.find_all(project_id).collect { |issue| self.new issue }
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
        issues.collect { |issue| self.new issue }
      end

      def self.open(project_id, *options)
        begin
          body = options.first.delete[:body]
          title = options.first.delete[:title]
          self.new TicketMaster::Provider::Github.api.create_issue("#{TicketMaster::Provider::Github.login}/#{project_id}", title, body, options)
        rescue
          self.find_all(project_id).last
        end
      end

      def save
        t = Ticket.find_by_id(project_id, number)
        return false if t.title == title and t.body == body
        t.title = title
        t.body = body
        t.save
        true
      end

    end
  end
end
