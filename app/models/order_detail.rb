class OrderDetail < ActiveRecord::Base
  belongs_to :order
  belongs_to :product
  
  def unit_price
	    product.price
	  end
	  
	  def full_price
	    unit_price*amount
	  end
	  
	  
	  def default_quantity_to_one
	    self.amount ||= 1
	  end
end
