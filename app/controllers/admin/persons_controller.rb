class Admin::PersonsController < Admin::ApplicationController
  before_action :get_person
  def index
    page = params[:page] ? (params[:page].to_i * 25) : 25
    @persons = Person.all
    @load_more = @persons.length > page ? true : false
    @persons = @persons.limit(page)
  end

  def show
    @groups = @person.groups
    @join_groups = @person.join_groups
  end

  def person_index
    page = params[:page] ? (params[:page].to_i * 25) : 25
    if params[:group_id]
      @group = Group.find_by(id: params[:group_id])
      @all_persons = @group.members
      @header = "#{@group.group_name} Community"
    end
    @load_more = @all_persons.length > page ? true : false
    @persons = @all_persons.limit(page)

  end
  def destroy
    @person.destroy
    redirect_to admin_persons_path()
  end
  private
  def get_person
    return if params[:id].nil?
    @person =  Person.find_by(id: params[:id])
  end
end
