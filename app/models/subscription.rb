# == Schema Information
#
# Table name: subscriptions
#
#  id                     :integer          not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  accountnumber          :string
#  accountname            :string
#  accountbalance         :integer
#  accountmrr             :integer
#  ownerfirstname         :string
#  ownerlastname          :string
#  owneremail             :string
#  subscriptionstatus     :string
#  subscriptionstartdate  :date
#  subscriptionendate     :date
#  subscriptioncanceldate :date
#  subscriptionid         :string
#  contracteffectivedate  :date
#  startdate              :date
#  initialterm            :integer
#  renewalterm            :integer
#  enddate                :date
#  createdate             :date
#  mrr                    :integer
#  product                :string
#  productrateplan        :string
#  rateplanperiod         :string
#  rateplantype           :string
#  rateplancreatedate     :string
#  rateplanchargeid       :string
#  amendment_type         :string
#

class Subscription < ActiveRecord::Base
	require 'spreadsheet'


	def create(json_entry)

	end

	def self.reset(file)
		Subscription.destroy_all
		Spreadsheet.client_encoding = 'UTF-8'
		spreadsheet = Spreadsheet.open(file)
		book = spreadsheet.worksheet 0
		book.each do |row|
			create_subscription_from_excel(row)
		end
		return Subscription.all

	end

	def update_by_date(json_from_date)
	end

	def self.create_subscription_from_excel(row)
		logger.info("#{row[RATE_PLAN_CHARGE_ID]}")
		if row[RATE_PLAN_CHARGE_ID] && row[RATE_PLAN_CHARGE_ID].to_s != RATE_PLAN_CHARGE_ID_HEADER.to_s
			subscription = Subscription.new
			subscription.accountnumber = row[ACCOUNT_NUMBER]
			subscription.accountname = row[ACCOUNT_NAME]
			subscription.accountbalance = row[ACCOUNT_BALANCE]
			subscription.mrr = row[MRR]
			subscription.ownerfirstname = row[OWNER_FIRSTNAME]
			subscription.ownerlastname = row[OWNER_LASTNAME]
			subscription.owneremail = row[OWNER_EMAIL]
			subscription.subscriptionstatus = row[SUBSCRIPTION_STATUS]
			subscription.subscriptionstartdate =row[SUBSCRIPTION_START_DATE]
			subscription.subscriptionendate = row[SUBSCRIPTION_END_DATE]
			subscription.subscriptioncanceldate = row[SUBSCRIPTION_CANCEL_DATE]
			subscription.subscriptionid = row[SUBSCRIPTION_ID]
			subscription.contracteffectivedate = row[CONTRACT_EFFECTIVE_DATE]
			subscription.startdate = row[START_DATE]
			subscription.initialterm = row[INITIAL_TERM]
			subscription.renewalterm = row[RENEWAL_TERM]
			subscription.enddate = row[END_DATE]
			subscription.createdate = row[CREATE_DATE]
			subscription.product = row[PRODUCT]
			subscription.productrateplan = row[PRODUCT_RATE_PLAN]
			subscription.rateplanperiod = row[RATE_PLAN_PERIOD]
			subscription.rateplantype = row[RATE_PLAN_TYPE]
			subscription.rateplancreatedate = row[RATE_PLAN_CREATE_DATE]
			subscription.rateplanchargeid = row[RATE_PLAN_CHARGE_ID]
			subscription.amendment_type = row[AMENDMENT_TYPE]
			subscription.save
		end
	end

end
