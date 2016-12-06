class Category < ActiveRecord::Base
	has_many :classifies
	has_many :products, :through => :classifies
	validates :name, presence: true


	has_many :passive_classifies,class_name: "Classify", foreign_key: "category_id"
	has_many :groupcategory, through: :passive_classifies, source: :product 
end
