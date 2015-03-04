desc "This task is called by the Heroku scheduler add-on"
task :update_contacts => :environment do
	require 'open-uri'
	puts "Updating contacts..."
	Contact.populate_from_update_list
	puts "done."
end

desc "this namespace deals with subscriptions and days"
namespace :subs do
	require 'open-uri'
	desc "This task updates the Day View for use in Bime"
	task :update_days => :environment do
		puts "Updating Days"
		Day.destroy_all
		Subscription.all.each {|sub| Day.day_from_subscription(sub)}
		puts "done"
	end

	desc "This task updates the subscriptions"
	task :update_subs => :environment do
		puts "Updating new subs"
		url = "https://awstest.wevideo.com/api/2/admin/analytics/zuora/mrr"
		Subscription.collect_from_database(url)
		puts "Updating churned subs"
		url = "https://awstest.wevideo.com/api/2/admin/analytics/zuora/churn"
		Subscription.collect_from_database(url)
		puts "done"
	end

	desc "This task updates the subs then updates the days"
	task :update_all do
		Rake::Task["subs:update_subs"].invoke
		Rake::Task["subs:update_days"].invoke
	end

end
