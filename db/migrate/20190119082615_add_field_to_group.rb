class AddFieldToGroup < ActiveRecord::Migration[5.2]
  def change
    add_reference :groups, :payperiod, index: true      
    add_foreign_key :groups, :payperiods
  end
end
