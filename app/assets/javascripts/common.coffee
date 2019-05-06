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
