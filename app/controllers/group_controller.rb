class GroupController < ApplicationController
#    acts_as_token_authentication_handler_for User
    before_action :authenticate_user!, except: [:index]
    skip_before_action :verify_authenticity_token

    def getGroupOfUser() 
        groups = current_user.groups
        groups_json = {}
        groups.each { | group |
            groups_json[group.id] = group.name
        }
        puts(groups_json)
        render json: groups_json
    end

    def delGroup() 
        @group = Group.find(params[:id])
        puts("Name: ", @group.name, ".\nID: ", @group.id)
        if @group == nil
            render :json => "403 Group not found", :status => 403
        else 
            puts(@group.destroy)
            render :json => "200 Success", :status => 200
        end
    end

end
