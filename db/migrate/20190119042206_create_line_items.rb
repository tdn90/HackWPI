class CreateLineItems < ActiveRecord::Migration[5.2] 
  def change
    create_table :line_items do |t|
      t.references :receipt, index: true, null: false, foreign_key: {on_delete: :cascade}, on_delete: :cascade
      t.string :item, null: false, default: ""
      t.float :price, null: false, default: 0    
      #auto create line_itemID  
    end
  end
end
