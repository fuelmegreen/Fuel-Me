module ApplicationHelper

  def avatar opts={}
    img_opts = (opts[:img] || {})
    img_opts[:class] = "avatar #{img_opts[:class]}"
    scale = img_opts.delete(:scale)

    div_opts = (opts[:div] || {}).merge!(id: :avatar)
    div_opts[:class] = scale if scale
    use_div = div_opts[:use].nil? || div_opts.delete(:use)

    src = current_user.avatar_url(scale)
    img_opts.merge!(dimensions(scale))
    img = image_tag(src, img_opts)
    use_div ? content_tag(:div, img, div_opts) : img
  end

  def dimensions scale
    num = case scale
      when :small ;  20
      when :thumb ;  60
      when :normal; 100
      when :large ; 200
    end
    num ? { width: num, height: num } : {}
  end

  def time_in_words time
    word = (Time.now - time) < 0 ? 'from now' : 'ago'
    "#{time_ago_in_words(time)} #{word}"
  end

  def render_if page
    case page
    when :home
      if page?(:home, :index)
        yield
      end
    else
      unless page?(:home, :index)
        yield
      end
    end
  end


  def current_action
    self.controller.action_name.underscore
  end
  alias_method :body_id, :current_action

  def current_controller
    self.controller.class.to_s.underscore.gsub(/_controller$/, '').gsub(/\W/, ' ').split.last
  end
  alias_method :body_class, :current_controller

  def page? name, action=nil
    if action
      current_controller == name.to_s &&
          current_action == action.to_s
    else
      current_controller == name.to_s ||
          current_action == 'index' ||
          /^\/#{name}$/ === request.path
    end
  end

  def action? name
    current_action == name.to_s
  end

  def section name, &block
    yield if page? name
  end

  def sub_section name, &block
    yield if action? name
  end

  def current_page *names
    'current' if page? *names
  end

  def menu_item *args
    opts  = args.extract_options!
    name  = args.first
    label = opts[:label].present? ? opts[:label] : name.to_s.capitalize
    href  = opts[:href].present? ? opts[:href] : "/#{name}"
    opts.merge!(class: 'selected') if action? name
    link_to label, href, opts
  end

  def google_analytics    
    return unless analytics(:google).enabled
    script = <<-SCRIPT
    <!-- Google Analytics -->
    <script type="text/javascript">
      var _gaq = _gaq || [];
      _gaq.push(['_setAccount', '#{analytics(:google).uid}']);
      _gaq.push(['_trackPageview']);

      (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
      })();

    </script>
    SCRIPT
    script.html_safe
  end

  def analytics service
    RConfig[:analytics][service]
  end

  def colored text, *colors
    content_tag :span, text, :style => "color:#{rgb(*colors)};"
  end

  def styled text, *attrs  
    font = [4,2].include?(attrs.size) ? self.font(attrs.pop) : nil
    content_tag :span, text, :style => "color:#{rgb(*attrs)};#{font}"
  end

  def rgb *colors
    return colors.first if colors.size == 1
    r,g,b = colors
    "rgb(#{r.to_i}, #{g.to_i}, #{b.to_i})"
  end

  def font name
    case name
    when :bold
      'font-weight:bold;'
    when :ital
      'font-style:italic;'
    else
      ''
    end
  end

  def email_link email
    return if email.blank?
    link_to email, "mailto:#{email}"
  end

  def blank_spacer
    '&nbsp;&nbsp;'.html_safe
  end
  def bullet_spacer
    '&nbsp;&#8226;&nbsp;'.html_safe
  end

  def bar_spacer
    '&nbsp;&#124;&nbsp;'.html_safe
  end

end # module 
