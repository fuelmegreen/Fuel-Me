class ApplicationController < ActionController::Base
  include ErrorManager, ParamsHandler
 
  helper :all
  protect_from_forgery

  before_filter :notifications
  before_filter :messages
  
  protected

  def notifications
    @notifications = current_user ? current_user.notifications : []
  end

  def messages
    @messages = current_user ? current_user.messages : []
  end

  def notify *args
    options = args.extract_options!
    redirect = options[:redirect]
    type = options[:type] || :success
    notice = type == :error ? type : :notice
    flash[:type] = type
    
    msg = args.first
    msg = 
      case msg
      when Symbol; I18n.t msg
      when String; msg
      end

    if redirect
      flash[notice] = msg
    else
      flash.now[notice] = msg
    end
  end

end
