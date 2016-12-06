class CreateDistricts < ActiveRecord::Migration[5.0]
  def change
    create_table :districts do |t|
      t.string :name
      t.string :unit
      t.string :location
      t.references :province, foreign_key: true

    end
  end
end
