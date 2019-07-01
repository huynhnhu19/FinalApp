window.Group =
  run: ->
    $(document).ready ->
      tickColor()
      tickThem()
      upvoteTick()
      tickColorWhenLoad()
      searchAdmin()
      closeAlertError()
tickColorWhenLoad = ->
  color = $("#category_color").val()
  $("##{color}").find("i").addClass("them-checked")

tickColor = ->
  $(".color").on "click", (e) ->
    $(".color-checked").removeClass("color-checked")
    $(this).find("i").addClass("color-checked")
    $("#group_text_color").val($(this).attr('id'))

tickThem = ->
  $(".them").on "click", (e) ->
    $(".them-checked").removeClass("them-checked")
    $(this).find("i").addClass("them-checked")
    $("#category_color").val($(this).attr('id'))
    
upvoteTick = ->
  $(".up-vote, .down-vote").click (e) ->
    e.preventDefault()
    $this = $(this)
    url = $this.data("url")
    $.ajax
      url: url
      method: 'post'
      datatype: 'JSON'
      success: (data) ->
        a = $this.parents(".post-voted")
        a.find(".upvoted").removeClass("upvoted")
        a.find(".downvoted").removeClass("downvoted")
        a.find(".vote-number").text(data.vote)

        if data.classColor == 'upvoted'
          a.find(".fa-arrow-up").addClass(data.classColor)
        else if data.classColor == 'downvoted'
          a.find(".fa-arrow-down").addClass(data.classColor)


searchAdmin = ->
  $("#search").on "keyup", (e) ->
    value = $(this).val().toLowerCase();
    $(".table tbody tr").filter ->
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
      if $("#search").val() == ""
        $(".load-more-footer").show()
      else
        $(".load-more-footer").hide()

closeAlertError = ->
  $("body .alert-error").delay(3000).slideUp(200)