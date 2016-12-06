require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@user = users(:linh)
  	#@order = Order.new(payment: 123.4, user_id: @user.id)
  	@order = @user.orders.build(payment: 123.4)
  end

  test "should be valid" do
  	assert @order.valid?
  end

  test "user id should be present" do
  	@order.user_id = nil
  	assert_not @order.valid?
  end
end
