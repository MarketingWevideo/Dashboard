class SubscriptionsController < ApplicationController

	def newsubs
		end_date = DateTime.now.strftime('%Q')
		logger.info "THIS IS THE END DATE #{end_date}"
		url = "http://awstest.wevideo.com/api/2/zuora/reporting/mrr?productName=WeVideo%20Pro&from=1420092000000&to=1420264800000&isChurn=false"
		logger.info "AND THIS IS NOW #{url}"
		 @subscription_list = JSON.parse(open(url).read)
	end
end
