$ ->
  $.fn.extend customize: (options) ->
    if not $.browser.msie or ($.browser.msie and $.browser.version > 6)
      @each ->
        currentSelected = $(this).find(":selected")
        $(this).after("<span class=\"custom-select\"><span class=\"custom-select-inner\">" + currentSelected.text() + "</span></span>").css
          position: "absolute"
          opacity: 0
          fontSize: $(this).next().css("font-size")

        selectBoxSpan = $(this).next()
        selectBoxWidth = parseInt($(this).width()) - parseInt(selectBoxSpan.css("padding-left")) - parseInt(selectBoxSpan.css("padding-right"))
        selectBoxSpanInner = selectBoxSpan.find(":first-child")
        selectBoxSpan.css display: "inline-block"
        selectBoxSpanInner.css
          width: selectBoxWidth
          display: "inline-block"

        selectBoxHeight = parseInt(selectBoxSpan.height()) + parseInt(selectBoxSpan.css("padding-top")) + parseInt(selectBoxSpan.css("padding-bottom"))
        $(this).height(selectBoxHeight).change ->
          selectBoxSpanInner.text($(this).find(":selected").text()).parent().addClass "changed"
