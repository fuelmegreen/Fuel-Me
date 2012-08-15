module ErrorManager

  NOT_FOUND_ERRORS = [
    ActiveRecord::RecordNotFound,
    ActionController::RoutingError, 
    ActionController::UnknownAction
  ]

  def self.included base
    base.class_eval do
      rescue_from CanCan::AccessDenied,        with: :error_403
      rescue_from SecurityError,               with: :error_403
#      rescue_from Exception, RuntimeError,     with: :error_500
      rescue_from *NOT_FOUND_ERRORS,           with: :error_404
      #rescue_from ActiveRecord::RecordInvalid, with: :error_invalid_record
    end
  end
 
  protected  

  def error_invalid_record exception
    record = exception.record
    respond_to do |format|
      format.html { render :action => (record.new_record? ? 'new' : 'edit') }
      format.js   { render :json => record.errors.full_messages, :status => :unprocessable_entity, :content_type => 'application/json' }
      format.json { render :json => record.errors.full_messages, :status => :unprocessable_entity, :content_type => 'application/json' }
    end
  end

  def error_401
    respond_to do |format|
      format.html { error_403 }
      format.js   { head :unauthorized }
      format.json { head :unauthorized }
    end
  end

  def error_403
    respond_to do |format|
      format.html do 
        notify :error, 'Please log in to access this page'
        redirect_to login_path
      end
      format.js   { head :forbidden }
      format.json { head :forbidden }
    end
  end

  def error_404
    respond_to do |format|
      format.html { render error_page(404) }
      format.js   { head :not_found        }
      format.json { head :not_found        }
      format.atom { head :not_found        }
    end
  end

  def error_500
    respond_to do |format|
      format.html { render error_page(500)      }
      format.js   { head :internal_server_error }
      format.json { head :internal_server_error }
    end
  end

  def error_page code
    {template: "errors/#{code}", layout: 'application', status: error_for(code)}
  end

  def error_for code
    case code
      when 404; :not_found
      when 500; :internal_server_error 
    end
  end

end
