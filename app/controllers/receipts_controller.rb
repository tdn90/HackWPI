class ReceiptsController < ApplicationController
    acts_as_token_authentication_handler_for User
    before_action :authenticate_user!, except: [:index]
    skip_before_action :verify_authenticity_token

    def index()
        id = params[:id]
        puts(id)
        @receipt = Receipt.find(id)
        @lines = @receipt.line_items        
    end

    def updateReceipt() 
        #@store = params[:store]

        @lines = params[:lines]
        puts("Processing!")
        #puts(@stores)
        #puts(@lines)
        @lines.each{ |line| 
            @lineItemID = line["id"]
            @item = line["desc"]
            @price = line["price"]
            #if lineTimeID = null then this is a new item
            if (@lineItemID == nil) 
                @receiptID = params[:id]
                newItem = LineItem.create(item: @item, price: @price, receipt_id: @receiptID)
                newItem.save!
                @lineItemID = newItem.id
            end

            #keep processing as normal
            puts(line["desc"])

            #puts(@lineItemID)
            #puts(line["price"])

            @people = line["people"]
            #puts(@people)

            @people.each { |user_id, val|
                puts(user_id)
                if (val)  #checked
                    # check if already there 
                    # if Person.exists?(['name LIKE ?', "%#{query}%"])
                    if Assigntable.exists?(['line_item_id = ? and user_id = ?', "%#{@lineItemID}%", "%#{user_id}%"]) 
                        puts("Record exists. Do nothing")
                    else 
                        puts("Add new record")
                        record = Assigntable.create(line_item_id: @lineItemID, user_id: Integer(user_id), status: 0)
                        record.save!
                    # else just add
                    end
                else  #unchecked
                    puts("remove anyway")
                    
                    begin
                        Assigntable.find(:conditions => ["line_item_id = ? and user_id = ?", @lineItemID, Integer(user_id)]).destroy                    
                    rescue ActiveRecord::RecordNotFound => e
                        my_record = nil
                    end
                end
            }
        }
        render plain: ""
    end

   

    def createReceipt() 
        name = params[:name]
        description = params[:description]
        user_id = current_user.id
        group_id = params[:groupID]
        group = Group.find(group_id)
        line_items = params[:lineItems]

        receipt = Receipt.create(name: name, description: description, user: current_user, group: group)
        receipt.save!

        for item in JSON.parse(line_items)
            li = LineItem.create(receipt_id: receipt.id, item: item[0], price: item[1])
            group.users.each{ | user | li.users << user }
            li.save!
            Assigntable.where(user: current_user, line_item: li).find_each{ |arow| 
                arow.status = 1
                arow.save!
            }
        end

        receipt.payperiod = group.payperiod
        receipt.save!

        render json: {"status": "OK"}
    end 

    def deleteReceipt()
        receiptID = params[:receipt_id]
        LineItem.where(receipt_id: receiptID).delete_all
        Receipt.where(id: receiptID).delete_all
    
        render json: {"status": "OK"}
    end
    
    def edit()
        recpt = Receipt.find(params[:id])
        
        if current_user != recpt.user
            render plain: "Unauthorized", status: :forbidden
            return
        end
        # stub
        render :edit, locals: {:edit=> true, :receipt => recpt}
    end
end
