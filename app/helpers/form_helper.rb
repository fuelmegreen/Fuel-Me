module FormHelper

  def text field, attrs={}
    form_field :text_field, field, attrs
  end

  def textarea field, attrs={}
    form_field :text_area, field, attrs
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

    attrs = Hashie::Mash.new({class: ''}.merge(attrs))
    form = attrs.delete(:form)

    if attrs.popover?
      popover = attrs.delete(:popover)
      title = popover.title || attrs.placeholder
      attrs.merge!('rel' => 'popover', 'data-original-title' => title, 'data-content' => popover.content)
    end

    lbl = ''
    if attrs.label?
      lbl_content = attrs.delete(:label).html_safe
      klass = attrs.delete(:klass)
      lbl = label(:user, field, lbl_content, class: klass || 'control-label').html_safe
    end

    field   = form ? form.send(type, field, attrs) : send(:"#{type}_tag", field, nil, attrs) unless attrs.no_field?
    control = div(field, class: 'controls')

    lbl << div(control, class: 'control-group')
  end

  def div content, options={}
    content_tag(:div, content, options)
  end
end
