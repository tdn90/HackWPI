class Payperiod < ApplicationRecord
    belongs_to :group    
    def is_expired()
        print(self.end.inspect)
        return false
    end
end
