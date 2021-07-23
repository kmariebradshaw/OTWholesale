class AddAttachmentToCustomers < ActiveRecord::Migration[6.1]
  def change
  	add_column :customers, :attachement, :string 
  end
end
