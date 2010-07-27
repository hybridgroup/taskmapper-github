module TicketMaster::Provider
  module Github
    # Project class for ticketmaster-github
    #
    #
    class Project < TicketMaster::Provider::Base::Project
      attr_accessor :prefix_options
      API = Octopi::Repository
      # declare needed overloaded methods here
      
      def initialize(object)
	hash = {'description' => object.description,
	        'url' => object.url,
	        'forks' => object.forks,
	        'name' => object.name,
	        'homepage' => object.homepage,
	        'watchers' => object.watchers,
	        'owner' => object.owner,
	        'private' => object.private,
	        'fork' => object.fork,
	        'open_issues' => object.open_issues,
	        'pledgie' => object.pledgie,
	        'size' => object.size,
	        'actions' => object.actions,
	        'score' => object.score,
	        'language' => object.language,
	        'followers' => object.followers,
	        'type' => object.type,
	        'username' => object.username,
	        'id' => object.id,
	        'pushed' => object.pushed,
	        'created' => object.created}
	
	puts "Hash => #{hash.inspect}"
	super hash
      end
      
      def self.search(options = {}, limit = 100)
	raise "Please supply arguments for search" if options.blank?
	if options.is_a? Hash
	  r = self.new(self::API.find(options))
	  puts "Result => #{r.inspect}"
	  [] << r
	else
	  self::API.find_all(options)[0...limit].collect { |repo| self.new repo }
	end
      end
      
      # copy from this.copy(that) copies that into this
      def copy(project)
        project.tickets.each do |ticket|
          copy_ticket = self.ticket!(:title => ticket.title, :description => ticket.description)
          ticket.comments.each do |comment|
            copy_ticket.comment!(:body => comment.body)
            sleep 1
          end
        end
      end

    end
  end
end


