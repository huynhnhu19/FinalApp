class GroupsController < ApplicationController
  def index
  	@groups = Group.all
  end

  def show
	@group = Group.find(params[:id])
  end

  def new
  	@group = current_person.groups.new
  end

  def create
  	@group = Group.create!(group_params)
  	@group.author = current_person
  	redirect_to root_path()
  end

  def join
  	@group = Group.find(params[:id])
  	@group.members << current_person
  	redirect_to groups_path()
  end

  private
  def group_params
  	params.require(:group).permit(:group_name)
  end
end
