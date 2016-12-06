class AddNoteToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :note, :string

  end
end
