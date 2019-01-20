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
            LineItem.create(receipt_id: receipt.id, item: item['item'], price: item['price']).save!
        end

        render plain: ""
    end 
end
