
$ ->

  $('.nav #edit').live 'click', (e) ->
    e.preventDefault()
    $('.nav li').removeClass('active')
    $('.profile-section').hide()
    $('#edit-profile').fadeIn()
    $(this).parents('li').addClass('active')

  $('.nav #password').live 'click', (e) ->
    e.preventDefault()
    $('.nav li').removeClass('active')
    $('.profile-section').hide()
    $('#change-password').fadeIn()
    $(this).parents('li').addClass('active')
  
  $('.nav #preferences').live 'click', (e) ->
    e.preventDefault()
    $('.nav li').removeClass('active')
    $('.profile-section').hide()
    $('#edit-preferences').fadeIn()
    $(this).parents('li').addClass('active')
  
  $('.sidebar-nav #avatar').popover()
  
  $('input').hover ->
    $(this).popover('show')

  $('a').hover ->
    $(this).popover('show')

  $("#new_user").validate({
    rules:
      'user[name]':
        required:true
      'user[username]':
        required:true
        remote: '/users/check'
      'user[email]':
        required:true
        email: true
        remote: '/users/check'
      'user[login]':
        required:true
      'user[password]':
        required:true
        minlength: 6
      'user[password_confirmation]':
        required:true
        equalTo: "#user_password"
    messages:
      'user[name]':"Enter your first and last name"
      'user[username]':
        required: 'Enter a username'
        remote:  jQuery.format("{0} is already in use")
      'user[email]':
        required:"Enter your email address"
        email:"Enter a valid email address"
        remote:  jQuery.format("{0} is already in use")
      'user[password]':
        required:"Enter your password"
        minlength:"Password must be minimum 6 characters"
      'user[password_confirmation]':
        required:"Enter confirm password"
        equalTo:"Passwords do not match"
    errorClass: "help-inline"
    errorElement: "span"
    highlight: (element, errorClass, validClass) ->
      $(element).parents('.control-group').removeClass('success')
      $(element).parents('.control-group').addClass('error')
    unhighlight: (element, errorClass, validClass) ->
      $(element).parents('.control-group').removeClass('error')
      $(element).parents('.control-group').addClass('success')
  })

  $("#forgot-password").live 'click', (e) ->
    e.preventDefault()
    # moz claims to, but versions <= 9 don't really (those ignorant savages)
    if $.support.transition && (!$.browser.mozilla || ($.browser.mozilla && parseInt($.browser.version) >= 10))
      $('.row').addClass('flipped')
      $('.row .back').show()
      #$('#user_login').focus()
    else
      $('.row .back').fadeIn('slow')
      $('#login').select()

  if errors?
    displayed_errors = []
    for own name, err of errors
      name = 'name' if name in ['first_name', 'last_name']
      err = err[0] if typeof err == 'object'

      continue if name in displayed_errors
      continue if typeof err == 'undefined'

      $("#user_#{name}").parents('.control-group').addClass('error')
      if !!$("#user_#{name}").parents('.field_with_errors').length
        parent = $("#user_#{name}").parents('.field_with_errors')
      else
        parent = $("#user_#{name}").parents('.controls')

      parent.html("#{parent.html()}<span for=\"user_#{name}\" generated=\"true\" class=\"help-inline\">#{name.humanize()} #{err}</span>")
      displayed_errors.push(name)
