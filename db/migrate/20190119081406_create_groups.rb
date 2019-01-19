class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      # add id automatically
      t.references :user, index: true, null: false, foreign_key: true
      # we will add pay period later      
    end
  end
end
