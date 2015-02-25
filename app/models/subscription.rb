# == Schema Information
#
# Table name: subscriptions
#
#  id                 :integer          not null, primary key
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  accountnumber      :integer
#  name               :string
#  status             :string
#  email              :string
#  startdate          :date
#  initialterm        :integer
#  renewalterm        :integer
#  enddate            :date
#  createdate         :date
#  product            :string
#  productrateplan    :string
#  rateplanperiod     :string
#  rateplantype       :string
#  rateplancreatedate :string
#

class Subscription < ActiveRecord::Base

	def create(json_date)
	end
end
