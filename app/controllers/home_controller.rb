class HomeController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    skip_before_action :verify_authenticity_token

    def index()
        # stub
    end
end
