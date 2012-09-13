class ApplicationController < ActionController::Base
  include ErrorManager, ParamsHandler
 
  helper :all
  helper_method :tweets, :my_tweets
  protect_from_forgery

  protected

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

  def my_tweets last=4
    tweets(RConfig[:social].twitter, last)
  end

  def tweets user, last=4
    Twitter.user_timeline(user)[0...last]
  end


end
