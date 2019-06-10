window.Post =
 	run: ->
 		$(document).ready ->
 			switchTag1()
 			switchTag2()
 			switchTag3()
 			previewPicture()
 			markQuestion()

switchTag1 = ->
	$(".new-post .btn-post").on "click", (e) -> 
		$('#post-box').css("display", "block")
		$('#video-box').css("display", "none")
		$('#link-box').css("display", "none")


switchTag2 = ->
	$(".new-post .btn-video").on "click", (e) -> 
		$('#post-box').css("display", "none")
		$('#video-box').css("display", "block")
		$('#link-box').css("display", "none")

switchTag3 = ->
	$(".new-post .btn-link").on "click", (e) -> 
		$('#post-box').css("display", "none")
		$('#video-box').css("display", "none")
		$('#link-box').css("display", "block")

previewPicture = ->
	$("body").on 'change', '#post_image', (event) ->
	    background = $('#image-background')
	    preview = $('#preview')
	    input = $(event.currentTarget)
	    file = input[0].files[0]
	    reader = new FileReader
	    reader.onload = (e) ->
	        image_base64 = e.target.result
	        background.attr 'src', image_base64
	        preview.attr 'src', image_base64

	    reader.readAsDataURL file
		
markQuestion = ->
	$("body").on 'click', '#question-btn', (event) ->
		if $(this).parents().find("#is_question").val() == "false" 
			$(this).parents().find("#is_question").prop("value", true)
			$(this).addClass("is_question")
			$(this).find(".fa").removeClass("fa-plus")
			$(this).find(".fa").addClass("fa-check")
			$(this).prop("title", "Unmark Question")
		else
			$(this).parents().find("#is_question").prop("value", false)
			$(this).removeClass("is_question")
			$(this).find(".fa").addClass("fa-plus")
			$(this).find(".fa").removeClass("fa-check")
			$(this).prop("title", "Mark as a Question")
