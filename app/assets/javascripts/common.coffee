$ ->
	$(".reply-comment").on "click", (e) ->
		$(this).hide()
		form_reply = $(this).parents(".comment-user").find(".box_form_comment")
		if form_reply.is(":visible")
			form_reply.css("display", "none")
		else
			form_reply.css("display", "inline")