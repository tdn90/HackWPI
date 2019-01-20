class PayPeriodController < ApplicationController
    acts_as_token_authentication_handler_for User
    before_action :authenticate_user!, except: [:index]
    skip_before_action :verify_authenticity_token

    def create_pay_period()
        puts(Time.now.getlocal.zone)

        render plain: ""
    end

    def checkApproval() 
        periodID = params[:id]
        period 
    end
end
