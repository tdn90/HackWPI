class GroupController < ApplicationController
  #    acts_as_token_authentication_handler_for User
  before_action :authenticate_user!, except: [:index]
  skip_before_action :verify_authenticity_token

  def getGroupOfUser()
    groups = current_user.groups
    groups_json = {}
    groups.each { |group|
      groups_json[group.id] = group.name
    }
    puts(groups_json)
    render json: groups_json
  end

  def delGroup()
    @group = nil
    begin
      @group = Group.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      @group = nil
      #render :json => "403 Group not found", :status => 403
    end
    #puts("Name: ", @group.name, ".\nID: ", @group.id)
    if @group == nil
      render :json => "403 Group not found", :status => 403
    else
      #puts(@group.destroy)
      @group.receipts.each { |receipt|
        receipt.line_items.each { |item|
          puts(item.id)
          Assigntable.where(line_item: item).delete_all
          item.destroy
        }
        receipt.destroy
      }
      @group.payperiods.each { |period| period.destroy }
      @group.destroy
      redirect_to "/dashboard/groups"
    end
  end

  def createGroup()
    admin_id = current_user.id
    name = params[:name]

    # Create group
    grp = Group.create(admin_id: admin_id, name: name)
    grp.save!

    groupID = grp.id
    current_time = Time.now
    cur_year = current_time.year
    cur_month = current_time.month
    cur_day = current_time.day
    startday = (cur_year.to_s + "-" + cur_month.to_s + "-" + cur_day.to_s).to_datetime
    endday = startday
    if (cur_day < 25)
      endday = (startday >> 1) - cur_day
    else
      endday = (startday >> 2) - cur_day
    end

    # Create payperiod
    pp = Payperiod.create(start: startday, end: endday, archived: 0, group_id: groupID, resultJson: "null")
    pp.save!

    # Set payperiod_id for group
    grp.payperiod = pp
    grp.save!

    redirect_to "/dashboard/groups"
  end

  def addUser()
    user = params[:user_email]
    group_id = params[:groupID]

    group = Group.find(group_id)

    usr = User.where(email: user)
    if (usr == nil)
      flash.alert = "User not found"
      render plain: "User Not Found", status: :notfound
    else
      flash.notice = "User added"
      group.users << usr
      redirect_to "/dashboard/groups/admin/" + params[:groupID]
    end
  end

  def attachGroupWithItem()
    groupID = params[:group_id]
    itemID = params[:item_id]
    @users = Group.find(groupID).users
    @users.each { |user| puts("Name: ", user.name, ";ID: ", user.id) }

    @lineItem = LineItem.find(itemID)
    @users.each { |user| Assigntable.create(line_item_id: itemID, user: user, status: 0).save! }

    #@lineItem.each { |lineItem| puts("Item: ", lineItem.item, ";price: ", lineItem.price) }
    render plain: ""
  end

  def leaveGroup()
    userID = current_user.id
    groupID = params[:group_id]

    # List of line items ID
    lid = Assigntable.where(user_id: userID).select("line_item_id")

    for item_id in lid
      rec_id = LineItem.where(id: item_id).select("receipt_id")
      if (Receipt.where(id: rec_id).select("group_id") == groupID)
        Assigntable.where(line_item_id: item_id).delete_all
      end
    end

    # Delete items from user's receipts
    for rid in Receipt.where(user_id: userID).ids
      LineItem.where(receipt_id: rid).delete_all
    end

    # Delete all receipts that user create
    Receipt.where(user_id: userID).delete_all

    GroupUser.where("user_id = #{userID} and group_id = #{groupID}").delete_all
    redirect_to "/dashboard/groups/"
  end

  def kickGroup()
    userID = params[:user_id]
    groupID = params[:group_id]

    # List of line items ID
    lid = Assigntable.where(user_id: userID).select("line_item_id")

    for item_id in lid
      rec_id = LineItem.where(id: item_id).select("receipt_id")
      if (Receipt.where(id: rec_id).select("group_id") == groupID)
        Assigntable.where(line_item_id: item_id).delete_all
      end
    end

    # Delete items from user's receipts
    for rid in Receipt.where(user_id: userID).ids
      LineItem.where(receipt_id: rid).delete_all
    end

    # Delete all receipts that user create
    Receipt.where(user_id: userID).delete_all

    GroupUser.where("user_id = #{userID} and group_id = #{groupID}").delete_all
    redirect_to "/dashboard/groups/admin/" + params[:group_id]
  end

  def index()
  end

  def info()
    g = Group.find(params[:id])
    unless (g.users.include? current_user)
      render plain: "Unauthorized", status: :forbidden
      return
    end

    curr_pay = g.current_pay_period()

    render :info, locals: { :group => g, :payperiod => curr_pay }
  end

  def admin()
    g = Group.find(params[:id])
    unless (g.admin == current_user)
      render plain: "Unauthorized", status: :forbidden
      return
    end

    curr_pay = g.current_pay_period()

    render :admin, locals: { :group => g, :payperiod => curr_pay }
  end

  def squareup()
    g = Group.find(params[:id])
    unless (g.admin == current_user)
      render plain: "Unauthorized", status: :forbidden
      return
    end
    curr_pay = g.current_pay_period()
    if (!curr_pay.all_receipts_done())
      redirect_to "/dashboard/groups/admin/#{g.id}"
    else
      user_user_pay = {}
      g.receipts.each { |recpt|
        recpt.line_items.each { |li|
          ct = li.users.count()
          li.users.each { |user|
            uu_key = recpt.user.id.to_s + "-" + user.id.to_s
            if (!user_user_pay.key?(uu_key))
              user_user_pay[uu_key] = 0.0
            end
            user_user_pay[uu_key] += li.price * 1.0 / ct
          }
        }
      }

      ptable = []
      ptable.append(["<b>Owes<b>"])
      skip = 0
      User.all.each { |user|
        ptable.append(["<b>" + user.name + "</b>"])
        ptable[0].append("<b>" + user.name + "</b>")
      }

      x_idx = 1
      oweTable = {}
      User.all.each { |user|
        y_idx = 1
        oweTable[user.id] = {}
        User.all.each { |user2|
          uu1 = user_user_pay[user.id.to_s + "-" + user2.id.to_s]
          uu2 = user_user_pay[user2.id.to_s + "-" + user.id.to_s]
          uu1 = 0.0 if uu1 == nil
          uu2 = 0.0 if uu2 == nil
          oweTable[user.id][user2.id] = (uu2 - uu1).round(2).to_s
          puts user.name + " is owed $" + (uu2 - uu1).to_s + " from " + user2.name

          ptable[x_idx][y_idx] = (uu2 - uu1).round(2).to_s
          y_idx = y_idx + 1
        }
        x_idx = x_idx + 1
      }
      
      curr_pay.resultJson = oweTable.to_json
      curr_pay.archived = true
      curr_pay.save!

      redirect_to "/dashboard/groups/viewperiod/#{curr_pay.id}"
    end

  end

  def showpayperiod()
    begin
      curr_pay = Payperiod.find(params[:id])
    rescue Exception
      raise ActionController::RoutingError, 'Not Found'
    end
    raise ActionController::RoutingError, 'Not Found' if (curr_pay == nil || curr_pay.archived == false)

    g = curr_pay.group
    unless (g.users.include? current_user)
      render plain: "Unauthorized", status: :forbidden
      return
    end

    render :showpayperiod, locals: {:paytable=> JSON.parse(curr_pay.resultJson), :payperiod => curr_pay}

  end
end
