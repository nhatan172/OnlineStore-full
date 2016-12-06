class Order::CartsController < Order::OrderController
	before_action :logged_in_user
	before_action :block_admin
  def show
  	if logged_in?
  		@cart = current_cart
  	else
  		redirect_to login_path
  	end
	end

	def destroy
		for cart_item in current_cart.cartdetails
			cart_item.destroy
		end
		redirect_to current_cart
	end
end
