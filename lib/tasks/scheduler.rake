desc "This task is called by the Heroku scheduler add-on"
task :update_contacts => :environment do
	require 'open-uri'
  puts "Updating contacts..."
  Contact.populate_from_update_list
  puts "done."
end

