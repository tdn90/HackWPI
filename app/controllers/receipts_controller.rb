class ReceiptsController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    skip_before_action :verify_authenticity_token

    def index()
        id = params[:id]
        puts(id)
        @receipt = Receipt.find(id)
        @lines = @receipt.line_items        
    end
end
