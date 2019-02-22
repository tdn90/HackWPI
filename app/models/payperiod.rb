class Payperiod < ApplicationRecord
    belongs_to :group    
    def is_expired()
        return DateTime.now > group.payperiod.end
    end

    def all_receipts_done()
        return get_unapproved_lineitems.count == 0
    end

    def get_unapproved_lineitems()
        ats = LineItem.where("receipts.payperiod_id = ? and assigntables.status != 1", self.id).joins(:receipt, :assigntables).select('assigntables.status, receipts.id as receipt_id, assigntables.user_id as unapprover_id, receipts.user_id as creator_id, receipts.name as recpt_name, line_items.item as name').uniq()
        """
        Receipt.where(payperiod_id: self.id).joins(:line_items).each { | receipt | 
            puts receipt.line_items.inspect
                Assigntable.where(line_item: li).each { | at | 
                    
                }
        }
        """
        return ats
    end
end
