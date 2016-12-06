class Cartdetail < ActiveRecord::Base
	belongs_to :product
	  belongs_to :cart
	  
	  before_create :default_quantity_to_one
	  
	  def unit_price
	    product.price
	  end
	  
	  def full_price
	    unit_price*amount
	  end
	  
	  
	  def default_quantity_to_one
	    self.amount ||= 1
	  end



	  def self.checkproduct(cartdetails, p)
	  	for c in cartdetails
	  		if (c.product_id.to_i == p.to_i)
	  			c.update_attributes(:amount => c.amount.to_i+1)
	  			return true
	  		end
	  	end
	  	false
	  end
end 
