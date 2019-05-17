$ ->
  $(document).ready ->
    upvotes = $('.upvoted')
    _.map(upvotes, (i) ->
      $(i).parents('.post-voted').find(".vote-number").addClass("upvoted")
    )

    downvotes = $('.downvoted')
    _.map(downvotes, (i) ->
      $(i).parents('.post-voted').find(".vote-number").addClass("downvoted")
    )

    $("body").on 'click', '#reply', ->
      reply_box = $(this).parents(".comment-user").find(".box_form_comment")
      if reply_box.is(":visible")
        reply_box.css("display", "none")
      else
        reply_box.css("display", "inline")