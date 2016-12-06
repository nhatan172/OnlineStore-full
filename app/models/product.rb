class Product < ActiveRecord::Base
	has_one :order_detail
	#has_many :classifies
	#has_many :categories, :through => :classifies 
	has_many :cartdetails
	validates :name, presence: true
	has_many :active_classifies, class_name: "Classify", foreign_key: "product_id"
	has_many :incategory, through: :active_classifies, source: :category #as followed



	def self.search(category_name, search)

		if(category_name[0].nil? || category_name[0].empty?)
			product = Product.all
		else
			category1 = Category.find_by_name(category_name)
			if !(category1)
				return product = nil;
			else
				product = category1.groupcategory
			end
		end
		if (search)
			searchdc = search.downcase		
			words = searchdc.split(/[^[[:word:]]]+/)
			for word in words
				product = product.select{ |e| e.name.downcase.include? word}
			end
			return product
		else
			return Product.all
		end
	end


end
