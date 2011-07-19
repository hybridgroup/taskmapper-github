module TicketMaster::Provider
  module Github
    # The comment class for ticketmaster-github
    #
    # Do any mapping between Ticketmaster and your system's comment model here
    # versions of the ticket.
    #
    class Comment < TicketMaster::Provider::Base::Comment
      attr_accessor :prefix_options

      def author
        self.user.login
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
        TicketMaster::Provider::Github.api.issue_comments(project_id, ticket_id).collect do |comment| 
          comment.merge!(:project_id => project_id, :ticket_id => ticket_id)
          self.new comment
        end
      end

      def self.create(project_id, ticket_id, comment)
        github_comment = TicketMaster::Provider::Github.api.add_comment(project_id, ticket_id, comment)
        github_comment.merge!(:project_id => project_id, :ticket_id => ticket_id)
        self.new github_comment
      end

    end
  end
end
