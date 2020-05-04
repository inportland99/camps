# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	# $(document).ready ->
	# 	myCookie = document.cookie.replace(/(?:(?:^|.*;\s*)summerpopup\s*\=\s*([^;]*).*$)|^.*$/, "$1")
	# 	#alert(myCookie)
	# 	if !myCookie
	# 		setTimeout ->
	# 			$("#signUpModal").modal('show')
	# 			date = new Date()
	# 			date.setTime date.getTime() + (24 * 60 * 60 * 1000)
	# 			exp = "; expires=" + date.toGMTString()
	# 			document.cookie = "summerpopup=true" + exp
	# 		, 45000

	#document.cookie = 'summerpopup' + '=; expires=Thu, 01 Jan 1970 00:00:01 GMT;'

	$("#revenue_link").on "click", ->
		orig_text = $(this).text()
		$(".revenue span").show()
		if orig_text is "Show"
			$(this).text("Hide")
		else
			$(this).text("Show")
			$(".revenue span").hide()

	if !(document.getElementById("installment-offer") is null)
    $('#installment-offer').delay(2000).fadeIn(1000)

	$(".modal").on "shown.bs.modal", ->
		$camp_video = $(this).find(".camp-video")
		if $(this).find(".camp-video").length != 0
			$camp_video.html('<iframe src=' + $camp_video.data('video') + 'width="640" height="360" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>')

$(document).ready ->
	  # Add minus icon for collapse element which is open by default
  $('.collapse.show').each ->
    $(this).prev('.card-header').find('.fa').addClass('fa-minus').removeClass 'fa-plus'
    return
  # Toggle plus minus icon on show hide of collapse element
  $('.collapse').on('show.bs.collapse', ->
    $(this).prev('.card-header').find('.fa').removeClass('fa-plus').addClass 'fa-minus'
    return
  ).on 'hide.bs.collapse', ->
    $(this).prev('.card-header').find('.fa').removeClass('fa-minus').addClass 'fa-plus'
    return
  return
