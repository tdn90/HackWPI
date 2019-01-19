class GroupController < ApplicationController
    before_action :authenticate_user!
    skip_before_action :verify_authenticity_token

    def getGroupOfUser() 
        user_id = current_user.id                
        #@groups = GroupUser.all(:conditions => { :user_id => user_id})
        @groups = GroupUser.find(:select => "group_id", :conditions => { :user_id => user_id})

        puts(@groups)
        result = GroupUser.all(:select => "id, user_id", :conditions => { :user_id => user_id})
        render :json => result
        render :json => ""
    end
end
