window.Group =
  run: ->
    $(document).ready ->
      tickColor()
      tickThem()
      joinGroup()
      leaveGroup()
      upvoteTick()
tickColor = ->
  $(".color").on "click", (e) ->
    $(".color-checked").removeClass("color-checked")
    $(this).find("i").addClass("color-checked")
    $("#group_text_color").val($(this).attr('id'))

tickThem = ->
  $(".them").on "click", (e) ->
    $(".color-checked").removeClass("them-checked")
    $(this).find("i").addClass("them-checked")
    $("#group_them").val($(this).attr('id'))

joinGroup = ->
  $(".btn-join-small").on 'click', (e) ->
    $(this).removeClass("active").addClass("de-active")
    $(this).parent().find(".btn-leave-small").removeClass("de-active").addClass("active")

leaveGroup = ->
  $(".btn-leave-small").on 'click', (e) ->
    $(this).removeClass("active").addClass("de-active")
    $(this).parent().find(".btn-join-small").removeClass("de-active").addClass("active")

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


