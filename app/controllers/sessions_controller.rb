class SessionsController < ApplicationController
 
  skip_before_filter :authenticate_user!, :except => :destroy

  def new
    render :layout => 'login'
  end

  def create
    #raise auth_profile.to_yaml

    logger.info "Auth Connect with current user: #{current_user.inspect}"
    @account = Account.from_omniauth(auth_profile, current_user)    
    @user = @account.user
    session[:account_id] = @account.id
    session[:user_id] = @user.id
    sign_in(:user, @user)

    if @user.email?
      notify "You are now signed in as #{@user.name}.", type: :success
      redirect_to root_url
    else
      notify "Please complete your registration.", type: :info 
      redirect_to '/users/complete'
    end
  end

  def destroy
    session[:user_id] = nil
    notify 'You are now signed out. Bye!', type: :success
    redirect_to root_url
  end

  def failure
    notify 'Authentication failed, please try again.', type: :error
    redirect_to root_url
  end

  private

  def auth_profile
    Hashie::Mash.new(request.env['omniauth.auth']).except(:extra)
  end
end
