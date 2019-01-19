class Receipt < ApplicationRecord
    belongs_to :user
    has_many   :line_items
    has_one    :payperiod
    belongs_to  :group
end