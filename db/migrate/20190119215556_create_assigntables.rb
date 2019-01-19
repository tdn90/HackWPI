class CreateAssigntables < ActiveRecord::Migration[5.2]
  def change
    create_table :assigntables do |t|
      t.integer :lineItem_id
      t.integer :user_id
      t.integer :status

      t.timestamps
    end

    add_index :assigntables, [:lineItem_id, :user_id]
  end
end
