module LayoutHelper

  def top_nav
    [
      ['/',        'Home',                 [:home, :index]   ],
      ['/about',   'About',                [:home, :about]   ],
      ['/resume',  'R&eacute;sum&eacute;', [:home, :resume]  ],
      ['/blog',    'Blog',                 [:blog, :index]   ],
      ['/contact', 'Contact',              [:home, :contact] ],
    ]
  end
  def web
    RConfig[:web]
  end

  def title
    show_title? && content_for?(:title) ? yield(:title) : web.title
  end

  def set_title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def page
    content_for(:page)
  end

  def set_page(page)
    content_for(:page) { h(page.to_s) }
  end

  def show_title?
    @show_title
  end

  def subtitle
    content_for(:subtitle) #if content_for?(:subtitle)
  end

  def set_subtitle subtitle
    content_for(:subtitle) { h(subtitle.to_s) }
  end

  def stylesheets *args
    content_for(:head) { stylesheet_link_tag *args }
  end

  def javascripts *args
    content_for(:head) { javascript_include_tag *args }
  end

  def meta_tag name, content=nil
    tag(:meta, name: name, content: content || web[name])
  end

  def meta_content_type
    tag(:meta, 'http-equiv' => 'content-type', content: 'text/html;charset=UTF-8')
  end

  def meta_tags include_csrf=true
    tags = []
    tags << meta_content_type
    tags << tag(:meta, charset: 'UTF-8')
    tags += %w[description keywords author robots viewport].map{|name| meta_tag(name) }
    tags << csrf_meta_tag if include_csrf
    tags.join("\n").html_safe
  end

  def favicon
    ['icon', 'shortcut icon'].map do |rel| 
      tag :link, rel: rel, href: 'favicon.ico', type: 'image/x-icon' 
    end.join("\n").html_safe
  end

  def copyright
    web.copyright.html_safe
  end

  def header_margin_top
    page?(:home, :index) ? 0 : -11
  end

  def clear_fix html
    content_tag :div, html, class: :clearfix
  end
  alias_method :cf, :clear_fix
end
