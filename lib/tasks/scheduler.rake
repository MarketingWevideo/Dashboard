desc "This task is called by the Heroku scheduler add-on"
task :update_contacts => :environment do
	require 'open-uri'
  puts "Updating contacts..."
  Contact.populate_from_update_list
  puts "done."
end

desc "This task updates the Day View for use in Bime"
task :update_days => :environment do
	puts "Updating Days"
	Day.destroy_all
	Subscription.all.each {|sub| Day.day_from_subscription(sub)}
	puts "done"
end
