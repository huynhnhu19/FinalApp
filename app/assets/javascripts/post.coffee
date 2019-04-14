window.Post =
 	run: ->
 		$(document).ready ->
 			switchTag1()
 			switchTag2()
 			switchTag3()

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
		
		
