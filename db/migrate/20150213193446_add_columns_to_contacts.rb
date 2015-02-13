class AddColumnsToContacts < ActiveRecord::Migration
  def change
  	add_column :contacts, :vid, :integer, null:false
  	add_column :contacts, :lifecycle, :string
  	add_column :contacts, :trial_join_date, :date
  	add_column :contacts, :trial_type, :string
  	add_column :contacts, :customer_stage, :string
  	add_column :contacts, :purchase_date, :date
  	add_column :contacts, :account_type, :string
  end
end
