class LineItemUser < ApplicationRecord
    belongs_to :lineItem
    belongs_to :user
end
