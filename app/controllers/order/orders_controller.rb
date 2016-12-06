class Order::OrdersController < Order::OrderController
	before_action :logged_in_user
  before_action :block_admin , only: [:new, :create]
  before_action :check_amount, only: :create

  def new
  	@order = Order.new
  	@cart = current_cart
  	@address = current_user.address_lists
  end

  def create
    session[:forwarding_url] = new_order_path
    session[:note] = a['note']
  	@address = current_user.address_lists
  	if current_cart.cartdetails.count == 0
  		flash[:danger] = "Please add product before check out"
  		redirect_to root_path
  		return
  	end
  	if !@address.any?
  	redirect_to new_address_list_path
  	else
  		@order = Order.create({:note => a['note'],:payment=>current_cart.total_price,:user_id => current_user.id,:address=>(AddressList.find_by_id(a['address_id']).to_string())})
  		for c in current_cart.cartdetails
  			OrderDetail.create({:amount=>c.amount,:order_id=>@order.id,:product_id=>c.product_id})
        c.product.update_attributes(:amount => c.product.amount - c.amount)
  		end
      session.delete(:note)
  		current_cart.destroy()
  		flash[:success] = "Sent order. We will contact soon. Thank you!"
  		redirect_to @order
  	end
  end

  def index
    if(current_user.admin?)
      @orders = Order.all.order(created_at: :desc)
    else
      @orders=current_user.orders.order(created_at: :desc)
    end
    if @orders.any?
      @orders = @orders.paginate(page: params[:page], :per_page => 10)
    end
  end

  def show
    @order = Order.find_by_id(params[:id])
    if @order.user_id != current_user.id && !current_user.admin?
      redirect_to root_path
      flash[:danger] = "You don't have permission to access"
    end
  end

  def a
      params.require(:order).permit(:address_id, :note)
  end

  def check_amount
    can = false
    s = "Product :"
    for cart_item in current_cart.cartdetails
      if(cart_item.amount > cart_item.product.amount)
        s = s + cart_item.product.name + " | "
        can = true
      end
    
    end
    if can == true 
       s = s+" are not enough"
      flash[:danger] = s
      redirect_to carts_path
    end
  end

end
