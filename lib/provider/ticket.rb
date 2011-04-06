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
            hash = {:description => object.description,
                    :created_at => object.created_at,
                    :name => object.name,
                    :id => object.name,
                    :owner => object.owner}
          else 
            hash = object
          end 
          super hash
        end
      end

      def self.find(project_id, *options)
        if options.first.empty?
          self.find_all(project_id)
        end
      end

      def self.find_by_attributes(project_id, attributes = {})
      issues = search_by_attribute(issues, attributes)
      end

      def self.find_all(project_id)
        issues = []
        issues += TicketMaster::Provider::Github.api.issues("#{TicketMaster::Provider::Github.login}/#{project_id}")
        state = 'close'
        begin
          issues += TicketMaster::Provider::Github.api.issues("#{TicketMaster::Provider::Github.login}/#{project_id}")
        rescue Error
          warn "Unable to fetch close issues due to timeout"
        end
      end

    end
  end
end
