class AddFieldToGroup < ActiveRecord::Migration[5.2]
  def change
    add_reference :groups, :payperiod, index: true, foreign_key: true    
    rename_column :groups, :user_id, :admin_id
    add_column :groups, :name, :string
  end
end
