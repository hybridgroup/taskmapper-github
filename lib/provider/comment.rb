module TaskMapper::Provider
  module Github
    # The comment class for taskmapper-github
    #
    # Do any mapping between TaskMapper and your system's comment model here
    # versions of the ticket.
    #
    class Comment < TaskMapper::Provider::Base::Comment

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
        Time.parse(self[:created_at])
      rescue
        self[:created_at]
      end

      def updated_at
        Time.parse(self[:updated_at])
      rescue
        self[:updated_at]
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
        self.new github_comment(project_id, ticket_id, comment[:body]).merge!(:project_id => project_id, :ticket_id => ticket_id)
      end

      def self.github_comment(project_id, number, body)
        TaskMapper::Provider::Github.api.add_comment(project_id, number, body)
      end

      # See https://www.kanbanpad.com/projects/31edb8d134e7967c1f0d#!xt-4f994f2101428900070759fd
      def self.clean_body!(comment)
        comment.body = comment.body.sub(/\A---\s\sbody:\s/, '').gsub(/\s\z/, '')
      end

      def save
        update_comment(project_id, id, body)
      end

      private
      def update_comment(repo, number, comment)
        TaskMapper::Provider::Github.api.update_comment repo, number, comment 
        true
      end


    end
  end
end
