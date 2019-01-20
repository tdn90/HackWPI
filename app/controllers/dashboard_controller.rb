class DashboardController < ApplicationController
    before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def index()
        
    end

    def approval()

    end

    def approve()
        Assigntable.where("user_id = #{current_user.id} and line_item_id = #{params[:id]}").each { | a | 
            a.status = 1
            a.save!
        }
        redirect_to dashboard_approvals_path
    end

    def approveAll()
        Assigntable.where("user_id = #{current_user.id} and (status is NULL or status = 0)").each { | a | 
            a.status = 1
            a.save!
        }
        redirect_to dashboard_approvals_path
    end

    def reject()
        Assigntable.where("user_id = #{current_user.id} and line_item_id = #{params[:id]}").each { | a | 
            a.status = 2
            a.save!
        }
        redirect_to dashboard_approvals_path
    end
end
