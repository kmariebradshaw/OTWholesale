class AddIssuesToCustomers < ActiveRecord::Migration[6.1]
  def change
  	add_column :customers, :issues, :string
  end
end
