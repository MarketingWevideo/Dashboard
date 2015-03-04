# == Schema Information
#
# Table name: days
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  daydate     :date
#  productname :string
#  newsubs     :integer
#  churnedsubs :integer
#  plan_period :string
#  mrrnew      :integer
#  mrrchurn    :integer
#

class Day < ActiveRecord::Base

	def self.day_from_subscription(subscription)
		new_day = Day.where(:daydate => subscription.startdate, :productname => subscription.product, :plan_period => subscription.rateplanperiod).first_or_initialize
		new_day.increment(:newsubs, by = 1)
		unless subscription.mrr.nil?
			new_day.increment(:mrrnew, by = subscription.mrr)
		end
		new_day.save
		if subscription.subscriptionstatus == "Cancelled"
			churn_day = Day.where(:daydate => subscription.enddate, :productname => subscription.product, :plan_period => subscription.rateplanperiod).first_or_initialize
			churn_day.increment(:churnedsubs, by = 1)
			unless subscription.mrr.nil?
				churn_day.increment(:mrrchurn, subscription.mrr)
			end
			churn_day.save
		end
		
		
		
	end


end