# ticketmaster-github

This is a provider for [ticketmaster](http://ticketrb.com). It provides interoperability with [Github](http://www.github.com/) and its issue tracking system through the ticketmaster gem.

# Usage and Examples

First we have to instantiate a new ticketmaster instance:
    github = TicketMaster.new(:github, {:username => "code", :password => "m4st3r!"})

If you do not pass in the token or both the username and password, it will only access public information for the account.

== Finding Projects

    project = github.project['project_name']
    project = github.project.find(:id => 505)

== Finding Tickets

    tickets = project.tickets
    

## Requirements

* rubygems (obviously)
* ticketmaster gem (latest version preferred)
* jeweler gem (only if you want to repackage and develop)
* Octopi gem provdes interface to Github

The ticketmaster gem should automatically be installed during the installation of this gem if it is not already installed.

## Other Notes

Since this and the ticketmaster gem is still primarily a work-in-progress, minor changes may be incompatible with previous versions. Please be careful about using and updating this gem in production.

If you see or find any issues, feel free to open up an issue report.


## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so we don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself so we can ignore when I pull)
* Send us a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 The Hybrid Group. See LICENSE for details.
