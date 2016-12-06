class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :content
      t.float :price
      t.integer :amount

      t.timestamps
    end
  end

end
