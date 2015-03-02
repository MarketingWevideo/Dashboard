class SubscriptionsController < ApplicationController

	def newsubs
		end_date = DateTime.now
		start_date = (end_date-1)
		#.strftime('%Q')		
		logger.info "THIS IS THE END DATE #{end_date}"
		url = "http://awstest.wevideo.com/api/2/zuora/reporting/mrr?from="+start_date.strftime('%Q')+"&to="+end_date.strftime('%Q')+"&isChurn=false"
		logger.info "AND THIS IS NOW #{url}"
		 @subscription_list = JSON.parse(open(url).read)
		 @result = Subscription.update_list(@subscription_list)
	end

	def reset
		logger.info("#{params["spreadsheet"]}")
		@subscriptions = Subscription.reset(params["spreadsheet"].tempfile)		
	end

	def upload
		@spreadsheet
	end

end
