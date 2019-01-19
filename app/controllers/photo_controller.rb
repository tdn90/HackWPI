class PhotoController < ApplicationController
    acts_as_token_authentication_handler_for User
    before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def upload()
        pict = params[:fileset]
        puts "Got a pict!"
        puts pict
        puts "Current user is " + current_user.name
        puts params
        render json: {"status": "OK"}
    end
end
