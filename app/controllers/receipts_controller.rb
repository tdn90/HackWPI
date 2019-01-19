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
        # line_items = params[:lineItems]

        Receipt.new(:name => name, :description => description, :user_id => user_id, :group_id => group_id)

        # for item in line_items
        #     LineItems.new(:item => item.item, :price => item.price, :receipt =>item.receipt.id).save
        puts("Name: ", name)
        puts("Desc: ", description)
        puts("UserID: ", user_id)
        puts("GroupID: ", group_id)
        render plain: ""
    end 
end
