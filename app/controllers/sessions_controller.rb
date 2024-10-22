class SessionsController < Devise::SessionsController
  respond_to :html, :js, :json

  def create
    person = Person.find_by(email: params[:person][:email])
    if person.nil?
      flash[:error] = "Email or password was wrong. Please check it again!"
      redirect_to :root
    else  
      resource = warden.authenticate!(:scope => resource_name, :recall => '#{controller_path}#failure')
      sign_in_and_redirect(resource_name, resource)
    end
  end

  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    return redirect_to :root
  end

  def failure
    return render :json => {:success => false, :errors => ["Login failed."]}
  end

end
