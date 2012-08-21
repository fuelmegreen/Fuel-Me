src_1 = "http://www.youtube.com/embed/1MnLxSBEDQA?rel=0&autoplay=1"
src_2 = "http://player.vimeo.com/video/24410070?title=0&byline=0&portrait=0&autoplay=1"
video = "<iframe class=\"video-embed\" width=\"795\" height=\"460\" frameborder=\"0\" src=\"#{src_1}\"></iframe>"

$ ->
  $('.play-button a').live 'click', (e) ->
    e.preventDefault()
    $('.play-button').hide()
    $('.video').css('opacity', '1.0').html(video) if video?

