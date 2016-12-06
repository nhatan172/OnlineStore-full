class CreateClassifies < ActiveRecord::Migration[5.0]
  def change
    create_table :classifies do |t|
      t.references :product, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
