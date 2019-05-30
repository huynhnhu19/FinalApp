window.ReplyComment =
	run: ->
	    $(document).ready ->
        showCommentBox()
        showReplyCommentBox()

showCommentBox= ->
  $("body").on 'click', '#reply', ->
    reply_box = $(this).closest(".comment-post-box").find(".box_form_comment").first()
    if reply_box.is(":visible")
      reply_box.css("display", "none")
    else
      reply_box.css("display", "inline")

showReplyCommentBox = ->
  $("body").on 'click', '#reply-comment', ->
    reply_box = $(this).closest(".comment-post-box").find(".box_form_comment").first()
    if reply_box.is(":visible")
      reply_box.css("display", "none")
    else
      reply_box.css("display", "inline")

