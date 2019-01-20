class AddFieldToReceipts < ActiveRecord::Migration[5.2]
  def change
    add_reference :receipts, :group, index: true      
    add_foreign_key :receipts, :groups, on_delete: :cascade
    
    add_reference :receipts, :payperiod, index: true      
    add_foreign_key :receipts, :payperiods, on_delete: :cascade
  end
end
