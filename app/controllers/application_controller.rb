class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  #returns false if current_user is nil
  def signed_in?
    puts current_user.inspect
    !current_user.nil?
  end

  #denies access if current_user is nil
  def authenticate
    puts "Authenticate called"
    deny_access unless signed_in?
  end

  # Store the current location and redirect to sign in.
  def deny_access
    puts "denying access"
    store_location
    redirect_to(new_user_session_url)
  end

  #after_sign_in_path_for is called by devise
  def after_sign_in_path_for(user)
    puts "after sign in path called by devise"
    unless session[:return_to]
      home_page(user)
    else
      return_to_path = return_to
      clear_return_to
      return_to_path
    end
  end

  def store_location
    if request.get?
      session[:return_to] = request.fullpath
    end
  end

  def return_to
    session[:return_to] || params[:return_to]
  end

  def clear_return_to
    session[:return_to] = nil
  end

  RESOURCE_TYPES = ResourceType.all
end
