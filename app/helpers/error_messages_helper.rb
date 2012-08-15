module ErrorMessagesHelper

  def flash_notice
    message, type = flash_message, flash_type
    message.blank? ? nil : [message, type]
  end

  def flash_message
    flash[:notice] || flash.now[:notice] ||
    flash[:error]  || flash.now[:error]  ||
    flash[:alert]  || flash.now[:alert]
  end

  def flash_type
    flash[:type] ||
    (flash[:error] && :error) ||
    (flash[:alert] && :alert) || :success
  end

  def flash_class
    flash_type == :alert ? '' : "alert-#{flash_type}"
  end

  def messages?
    flash_notice.present?
  end

  def devise_errors?
    devise_error_messages!.present?
  end

  # Render error messages for the given objects. The :message and :header_message options are allowed.
  def error_messages_for(*objects)
    options = objects.extract_options!
    options[:header_message] ||= I18n.t(:"activerecord.errors.header", :default => "Invalid Fields")
    options[:message] ||= I18n.t(:"activerecord.errors.message", :default => "Correct the following errors and try again.")
    messages = objects.compact.map { |o| o.errors.full_messages }.flatten
    unless messages.empty?
      content_tag(:div, :class => "error_messages") do
        list_items = messages.map { |msg| content_tag(:li, msg) }
        content_tag(:h2, options[:header_message]) + content_tag(:p, options[:message]) + content_tag(:ul, list_items.join.html_safe)
      end
    end
  end

  module FormBuilderAdditions
    def error_messages(options = {})
      @template.error_messages_for(@object, options)
    end
  end
end

ActionView::Helpers::FormBuilder.send(:include, ErrorMessagesHelper::FormBuilderAdditions)
