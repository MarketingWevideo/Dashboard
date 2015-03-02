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

	def self.update_list(subscription_list)
		subscription_array = []
		subscription_list.each do |object|
			subscription_array << create_subscription_from_json(object)
		end
		return subscription_array
	end

	def self.create_subscription_from_json(object)
		subscription = Subscription.where(:rateplanchargeid => object["RatePlanChargeId"]).first_or_initialize
		subscription.accountname = object["Account Name"]
		subscription.accountbalance = object["Account Balance"]
		subscription.mrr = object["New charge MRR"]
		subscription.ownerfirstname = nil
		subscription.ownerlastname = nil
		subscription.owneremail = object["Work Email"]
		subscription.subscriptionstatus = object["Status"]
		subscription.subscriptionstartdate = convert_date(object["Subscription Start Date"]["time"])
		subscription.subscriptionendate = convert_date(object["Subscription End Date"]["time"])
		subscription.subscriptioncanceldate = convert_date(object["Cancelled Date"]["time"])
		subscription.subscriptionid = object["subcriptionId"]
		subscription.contracteffectivedate = convert_date(object["Contract Effective Date"]["time"])
		subscription.startdate = convert_date(object["Effective Start Date"]["time"])
		subscription.initialterm = object["Initial Term"]
		subscription.renewalterm = object["Renewal Term"]
		subscription.enddate = convert_date(object["Subscription End Date"]["time"])
		subscription.createdate = convert_date(object["Subscription Created Date"]["time"])
		subscription.product = object["Product Name"]
		subscription.productrateplan =  object["Product Rate Plan Name"]
		subscription.rateplanperiod = object["Rate Plan Period C"]
		subscription.rateplantype = object["Rate Plan Type C"]
		subscription.rateplancreatedate = convert_date(object["Rate Plan Charge Created Date"]["time"])
		subscription.rateplanchargeid = object["RatePlanChargeId"]
		subscription.amendment_type = object["Amendment Type"]
		logger.info("#{subscription.attributes}")
		subscription.save
		return subscription
	end

	def self.convert_date(object_date)
		unless object_date.nil?
			date = (object_date.to_f/1000).to_s
			Date.strptime(date, '%s')
		end
	end

end
