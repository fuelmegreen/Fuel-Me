module FormHelper

  def text field, attrs={}
    form_field :text_field, field, attrs
  end

  def password field, attrs={}
    form_field :password_field, field, attrs
  end

  def checkbox field, attrs={}
    attrs = Hashie::Mash.new(attrs)
    lbl = attrs.label || field.humanize
    cb = check_box_tag(field) << lbl.html_safe
    label(:user, field, cb.html_safe, class: :checkbox).html_safe
  end

  def empty_label label, attrs={}
    form_field nil, nil, attrs.merge(label: label, no_field: true)
  end

  def profile_avatar
    title = 'original-title'
    avatar(
      img: {
        class: :profile,
        scale: :normal, 
        data: {
          toggle: 'modal', 
          target: '#avatar-modal',  
        }
      },
      div: {
        rel:     'popover', 
        data: {
          content: 'Click to upload a new avatar photo.',
          title => 'Avatar'
        }
      }
    )
  end

  private

  def form_field type, field, attrs={}
    attrs = Hashie::Mash.new({class: 'input-xlarge'}.merge(attrs))
    attrs.placeholder = field.to_s.humanize unless attrs.placeholder?
    form = attrs.delete(:form)

    if attrs.popover?
      popover = attrs.delete(:popover)
      title = popover.title || attrs.placeholder
      attrs.merge!('rel' => 'popover', 'data-original-title' => title, 'data-content' => popover.content)
    end

    field   = form ? form.send(type, field, attrs) : send(:"#{type}_tag", field, nil, attrs) unless attrs.no_field?
    control = div(field, class: 'controls')

    lbl = ''
    if attrs.label?
      lbl = label(:user, field, attrs.label.html_safe, class: attrs.klass || 'left-side').html_safe
    end

    lbl << div(control, class: 'control-group')
  end

  def div content, options={}
    content_tag(:div, content, options)
  end
end
