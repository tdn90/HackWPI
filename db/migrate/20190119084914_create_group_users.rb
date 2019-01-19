class CreateGroupUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :group_users do |t|
      t.references :user, index: true, null: false, foreign_key: true
      t.references :group, index: true, null: false, foreign_key: true
    end
  end
end
