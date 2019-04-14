window.ReplyComment =
	run: ->
    	$(document).ready ->
  			showInputFieldReply()

showInputFieldReply = ->
  $(".reply-comment").on "click", (e) ->
    form_reply = $(this).parents(".comment-user").find(".box_form_comment")
  		debugger
    if form_reply.is(":visible")
      form_reply.css("display", "none")
    else
      form_reply.css("display", "block")
