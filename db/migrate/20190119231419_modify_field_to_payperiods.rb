class ModifyFieldToPayperiods < ActiveRecord::Migration[5.2]
  def change
    rename_column :payperiods, :boolean, :archived
  end
end
