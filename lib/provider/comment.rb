module TaskMapper::Provider
  module Github
    # The comment class for taskmapper-github
    #
    # Do any mapping between TaskMapper and your system's comment model here
    # versions of the ticket.
    #
    class Comment < TaskMapper::Provider::Base::Comment
      attr_accessor :prefix_options

      def initialize(*object) 
        if object.first 
          object = object.first
          unless object.is_a? Hash
            hash = {:id => object.id,
                    :body => object.body,
                    :created_at => object.created_at,
                    :author => object.user.login}
          else
            hash = object
          end
          super hash
        end
      end

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

      def self.find_by_attributes(project_id, ticket_id, attributes = {})
        search_by_attribute(self.find_all(project_id, ticket_id), attributes)
      end

      def self.find_all(project_id, ticket_id)
        current_time = Time.now.httpdate
        Array(TaskMapper::Provider::Github.api.issue_comments(project_id, ticket_id, :since => current_time)).collect do |comment|
          comment.merge!(:project_id => project_id, :ticket_id => ticket_id)
          clean_body! comment
          self.new comment
        end
      end

      def self.create(project_id, ticket_id, comment)
        comment = comment[:body]
        github_comment = TaskMapper::Provider::Github.api.add_comment(project_id, ticket_id, comment)
        github_comment.merge!(:project_id => project_id, :ticket_id => ticket_id)
        self.new github_comment
      end

      # See https://www.kanbanpad.com/projects/31edb8d134e7967c1f0d#!xt-4f994f2101428900070759fd
      def self.clean_body!(comment)
        comment.body = comment.body.sub(/\A---\s\sbody:\s/, '').gsub(/\s\z/, '')
      end

      def save
        update_comment(project_id, id, body)
      end

      private
      def update_comment(repo, number, comment, options = {})
        TaskMapper::Provider::Github.api.update_comment repo, number, comment, options
        true
      end


    end
  end
end
