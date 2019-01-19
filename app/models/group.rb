class Group < ApplicationRecord
    belongs_to :user
    has_one :payperiod
end
