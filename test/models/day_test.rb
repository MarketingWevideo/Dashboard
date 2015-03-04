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

require 'test_helper'

class DayTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
