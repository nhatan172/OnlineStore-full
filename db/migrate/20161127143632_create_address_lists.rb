class CreateAddressLists < ActiveRecord::Migration[5.0]
  def change
    create_table :address_lists do |t|
      t.string :name
      t.string :address
      t.string :phone_number
      t.boolean :default
      t.references :ward, foreign_key: true
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end
