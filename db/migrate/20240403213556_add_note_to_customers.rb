class AddNoteToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :note, :string
  end
end
