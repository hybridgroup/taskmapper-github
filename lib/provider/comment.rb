module TicketMaster::Provider
  module Github
    # The comment class for ticketmaster-github
    #
    # Do any mapping between Ticketmaster and your system's comment model here
    # versions of the ticket.
    #
    class Comment < TicketMaster::Provider::Base::Comment
      attr_accessor :prefix_options
      
      def initialize(*options)
        if options.first.is_a? Hash
          object = options.first
          @system_data = {:client => object}
          object[:author] = object['user']
          object[:project_id] = options[1]
          object[:ticket_id] = options[2]
          super object
        end
      end

      def created_at
        @created_at ||= begin
          Time.parse(self[:created_at])
          rescue
          self[:created_at]
          end
      end

       def updated_at
        @updated_at ||= begin
          Time.parse(self[:updated_at])
          rescue
          self[:updated_at]
          end
      end
      
      # declare needed overloaded methods here
       
      def self.find(project_id, ticket_id)
        TicketMaster::Provider::Github.api.issue_comments("#{TicketMaster::Provider::Github.login}/#{project_id}", ticket_id).collect { |comment| self.new comment }
      end

      def self.create(project_id, ticket_id, comment)
        self.new TicketMaster::Provider::Github.api.add_comment("#{TicketMaster::Provider::Github.login}/#{project_id}", ticket_id, comment)
      end

    end
  end
end
