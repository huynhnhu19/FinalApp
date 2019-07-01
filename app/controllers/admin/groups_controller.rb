class Admin::GroupsController < Admin::ApplicationController
  before_action :get_group
  def index
    page = params[:page] ? (params[:page].to_i * 25) : 25
    @groups = Group.all
    @load_more = @groups.length > page ? true : false
    @groups = @groups.limit(page)
  end

  def show
  end

  def group_index
    page = params[:page] ? (params[:page].to_i * 25) : 25
    if params[:person_id]
      @person = Person.find_by(id: params[:person_id])
      @all_groups = @person.join_groups
    end
    @load_more = @all_groups.length > page ? true : false
    @groups = @all_groups.limit(page)
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
