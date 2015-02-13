# == Schema Information
#
# Table name: contacts
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  vid             :integer          not null
#  lifecycle       :string
#  trial_join_date :date
#  trial_type      :string
#  customer_stage  :string
#  purchase_date   :date
#  account_type    :string
#

require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
