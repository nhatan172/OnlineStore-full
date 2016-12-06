class CreateWards < ActiveRecord::Migration[5.0]
  def change
    create_table :wards do |t|
      t.string :name
      t.string :unit
      t.string :location
      t.references :district, foreign_key: true

    end
  end
end
