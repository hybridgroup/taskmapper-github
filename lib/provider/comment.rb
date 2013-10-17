module TaskMapper::Provider
  module Github
    class Comment < TaskMapper::Provider::Base::Comment
      def initialize(*object)
        object = object.first if object.is_a?(Array)
        super(object) if object.is_a?(Hash)
      end

      def author
        self.user.login
      end

      def self.find_by_attributes(project_id, ticket_id, attributes = {})
        search_by_attribute(find_all(project_id, ticket_id), attributes)
      end

      def self.find_all(project_id, ticket_id)
        comments = Array(api.issue_comments(project_id, ticket_id))
        comments.collect do |comment|
          comment = comment.attrs
          comment.merge! :project_id => project_id, :ticket_id => ticket_id
          clean_body! comment
          self.new comment
        end
      end

      def self.create(project_id, ticket_id, comment)
        comment = api.add_comment(project_id, ticket_id, comment[:body])
        comment = comment.attrs
        comment.merge!(:project_id => project_id, :ticket_id => ticket_id)
        self.new comment
      end

      # See https://www.kanbanpad.com/projects/31edb8d134e7967c1f0d#!xt-4f994f2101428900070759fd
      def self.clean_body!(comment)
        comment[:body] = comment[:body].sub(/\A---\s\sbody:\s/, '').gsub(/\s\z/, '')
      end

      def save
        update_comment project_id, id, body
      end

      private
      def update_comment(repo, id, comment)
        new = api.update_comment repo, id, comment
        attrs = new.attrs
        clean_body! attrs
        self.merge!(attrs)
      end

      def self.api
        TaskMapper::Provider::Github.api
      end

      def api
        self.class.api
      end
    end
  end
end
