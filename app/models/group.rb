class Group < ApplicationRecord
    #belongs_to :user
    belongs_to :admin, :class_name=>"User"
    has_one :payperiod
    has_many :receipts, :dependent => :delete_all
    has_and_belongs_to_many :users
    has_many :payperiods
    #has_many :users    

    def current_pay_period()
        grps = Payperiod.where(:group => self, :archived=>0)
        if (grps.count > 0)
            return grps[0]
        else
            return nil
        end
    end
end
