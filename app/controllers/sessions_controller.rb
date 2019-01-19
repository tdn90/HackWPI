class SessionsController < Devise::SessionsController
    def new
        super
    end
    skip_before_action :verify_authenticity_token#,# only: [:api_create]

    respond_to :html, :json

    def create
        self.resource = warden.authenticate!(auth_options)
        set_flash_message!(:notice, :signed_in)
        sign_in(resource_name, resource)

        if (params[:mode] != nil && params[:mode] == 'json')
            render json: {user_email: resource.email, authentication_token: resource.authentication_token, user_name: resource.name}
        else
            yield resource if block_given?
            respond_with resource, location: after_sign_in_path_for(resource)
        end
    end
end
