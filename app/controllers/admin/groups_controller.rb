class Admin::GroupsController < Admin::ApplicationController
  before_action :get_group
  def index
    @groups = Group.all
  end
  def show
  end
  def destroy
    @group.destroy
    redirect_to admin_groups_path()
  end
  private
  def get_group
    @group = Group.find_by(id: params[:id])
  end
end
