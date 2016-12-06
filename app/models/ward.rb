class Ward < ApplicationRecord
  belongs_to :district
  has_many :address_lists
  has_many :users, through: :address_lists

end