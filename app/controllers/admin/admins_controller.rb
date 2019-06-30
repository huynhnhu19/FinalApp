class Admin::AdminsController < Admin::ApplicationController
  def index
    @person = Person.last
  end
end
