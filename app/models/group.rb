class Group < ApplicationRecord
    #belongs_to :user
    belongs_to :admin, :class_name=>"User"
    has_one :payperiod
    has_many :receipts
    has_and_belongs_to_many :users
    #has_many :users    
end
