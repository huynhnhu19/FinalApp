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

    $(".alert-error").delay(5000).slideUp(200)