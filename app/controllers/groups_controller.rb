class GroupsController < ApplicationController
  before_action :require_login
  def index
    @user = current_user
    @myg = []
    @otherg = []
    Group.all.each do |g|
      if Membership.where(group: g, user: @user).count == 0
        @otherg << g
      else
        @myg << g
      end
    end
  end

  def create
    group_params = params.require(:group).permit(:name, :description)
    group = current_user.groups.create(group_params)
    if group.valid?
      Membership.create(group: group, user: current_user)
    else
      flash[:error] = group.errors.full_messages
    end
    redirect_to "/groups"
  end

  def show
    @group = Group.find(params[:g_id])
    @creator = @group.creator
    @creatorInG = (Membership.where(user: @creator, group: @group).count > 0) ? true : false
    @others =  Membership.where(group: @group).where.not(user: @creator)
  end

  def join
    group = Group.find(params[:g_id])
    Membership.create(user: current_user, group: group)
    redirect_to "/"
  end

  def leave
    group = Group.find(params[:g_id])
    Membership.find_by(user: current_user, group: group).delete
    if Membership.where(group: group).count == 0
      group.delete
    end
    redirect_to "/groups"
  end
end
