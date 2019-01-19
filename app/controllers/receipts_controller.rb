class ReceiptsController < ApplicationController
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
        group_id = params[:groupID]
        puts("Name: ", name)
        puts("Desc: ", description)
        puts("GroupID: ", group_id)
        render plain: ""
    end 
end
