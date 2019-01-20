class Receipt < ApplicationRecord
    def change
        create_table :child do |t|
          t.references :parent, foreign_key: {on_delete: :cascade}
        end
    end
    belongs_to :user
    has_many   :line_items, :dependent => :delete_all
    has_one    :payperiod
    belongs_to  :group    
end