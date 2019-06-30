class Admin::PersonsController < Admin::ApplicationController
  before_action :get_person
  def index
    @persons = Person.all
  end

  def show
    @groups = @person.groups
    @join_groups = @person.join_groups
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
