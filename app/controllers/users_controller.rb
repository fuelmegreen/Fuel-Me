class UsersController < InheritedResources::Base
  respond_to :html, :json

  actions :new, :create, :show, :edit, :update

  before_filter :authenticate_user!, :except => [:new, :create, :check]

  def complete
    @account = Account.find(session[:account_id])
    if request.post?
      if current_user.update_attributes(param.user)
        @account.update_attributes(email: current_user.email)
        notify "You are now signed in as #{current_user.name}.", type: :success
        sign_in(:user, current_user)
        redirect_to root_url
      else
        notify "Update failed. Please correct errors.", type: :error
        render :complete
      end
    end
  end

  def check
    render :text => user_exists?
  end

  protected

  def user_exists?
    return true unless User.find_by_email(param.user.email).nil?
    return true unless User.find_by_username(param.user.username).nil?
    false
  end

  def resource
    current_user
  end

end

