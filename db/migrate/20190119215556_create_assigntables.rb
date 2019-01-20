class CreateAssigntables < ActiveRecord::Migration[5.2]
  def change
    create_table :assigntables do |t|
      t.integer :line_item_id
      t.integer :user_id
      t.integer :status

      t.timestamps
    end

    add_index :assigntables, [:line_item_id, :user_id]
  end
end
