class DashboardController < ApplicationController
    before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def index()
        
    end
end
