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


    def createGroup()
        admin_id = current_user.id
        payperiod_start = params[:start].to_datetime
        payperiod_end = params[:end].to_datetime
        name = params[:name]

        puts(admin_id)
        puts(payperiod_start.class)
        puts(payperiod_end.class)
        puts(name)

        grp = Group.create(admin_id: admin_id, name: name)
        grp.save!
        puts(grp.id)
        Payperiod.create(start: payperiod_start, end: payperiod_end, group_id: grp.id).save!
        

        render plain: ""
    end

end
