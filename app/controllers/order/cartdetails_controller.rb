class Order::CartdetailsController < Order::OrderController
	before_action :block_admin
	before_action :logged_in_user
	
  def create
  	if 	logged_in?
  		if Cartdetail.checkproduct(current_cart.cartdetails,cartdetail_params['product_id'])
   			session[:forwarding_url] = request.env['HTTP_REFERER'] || products_url
  			redirect_to carts_path
  		else
	  		current_cart.cartdetails.create!(cartdetail_params)
   			session[:forwarding_url] = request.env['HTTP_REFERER'] || products_url
		    redirect_to carts_path
		end
	else
		session[:forwarding_url] = request.env['HTTP_REFERER'] || products_url
        flash[:danger] = "Please log in"
		redirect_to login_path
  	end

	end

	def destroy
		current_cart.cartdetails.find_by(:product_id => cartdetail_params['product_id']).destroy
    	flash[:success] = "Product was removed"
    	redirect_to carts_path
	end

	def update
		if(cartdetail_params['amount'].to_i == current_cart.cartdetails.find_by(:product_id => cartdetail_params['product_id']).amount.to_i )
    		redirect_to carts_path
			return flash[:success] = "Nothing to do"
		end
		current_cart.cartdetails.find_by(:product_id => cartdetail_params['product_id']).update_attributes(:amount => cartdetail_params['amount'].to_i)
		flash[:success] = "Cart was updated"
    	redirect_to carts_path
	end

	def cartdetail_params
		params.require(:cartdetail).permit(:product_id, :amount)
	end
end
