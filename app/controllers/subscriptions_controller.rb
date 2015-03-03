class SubscriptionsController < ApplicationController
	

	def newsubs
		url = "https://awstest.wevideo.com/api/2/admin/analytics/zuora/mrr"
		@result = Subscription.collect_from_database(url)
	end

	def reset
		logger.info("#{params["spreadsheet"]}")
		@subscriptions = Subscription.reset(params["spreadsheet"].tempfile)		
	end

	def upload
		@spreadsheet
	end

	def churnsubs
		url = "https://awstest.wevideo.com/api/2/admin/analytics/zuora/churn"
		@result = Subscription.collect_from_database(url)
	end



end
