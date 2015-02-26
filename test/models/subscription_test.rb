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

require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
