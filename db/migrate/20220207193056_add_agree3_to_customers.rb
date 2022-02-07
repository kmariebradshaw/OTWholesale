class AddAgree3ToCustomers < ActiveRecord::Migration[6.1]
  def change
  	 add_column :customers, :agree3, :boolean
  end
end
