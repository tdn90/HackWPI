class LineItem < ApplicationRecord
    belongs_to :receipt    
    #has_many :line_item_users
    has_many :assigntables
    has_many :users, through: :assigntables
end
