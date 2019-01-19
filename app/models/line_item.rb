class LineItem < ApplicationRecord
    belongs_to :receipt    
    #has_many :line_item_users
end
