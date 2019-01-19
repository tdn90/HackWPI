class CreateReceipts < ActiveRecord::Migration[5.2]
  def change
    create_table :receipts do |t|
      t.string :name,      null: false, default: ""
      t.text   :description

      t.references :user, index: true, null: false, foreign_key: true
      t.boolean :paid, null: false, default: false;
      t.datetime :created_at
    end
  end
end
