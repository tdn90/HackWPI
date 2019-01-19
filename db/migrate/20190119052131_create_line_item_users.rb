class CreateLineItemUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :line_item_users do |t|
      t.references :line_item, index: true, null: false, foreign_key: true
      t.references :user, index: true, null: false, foreign_key: true
      t.integer :status, null: false, default: 0 
    end
  end
end
