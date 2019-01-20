class PayPeriodController < ApplicationController
    acts_as_token_authentication_handler_for User
    before_action :authenticate_user!, except: [:index]
    skip_before_action :verify_authenticity_token

    def create_pay_period()
        groupID = params[:group_id]
        current_time = Time.now
        cur_year = current_time.year
        cur_month = current_time.month
        cur_day = current_time.day
        startday = (cur_year.to_s + "-" + cur_month.to_s + "-" + cur_day.to_s).to_datetime
        endday = startday
        if(cur_day < 25)
            endday = (startday >> 1) - cur_day
        else
            endday = (startday >> 2) - cur_day
        end

        pp = Payperiod.create(start: startday, end: endday, archived: 1, group_id: groupID)
        pp.save!

        
        render plain: ""
    end

    def checkApproval() 
        periodID = params[:id]
        period 
    end
end
