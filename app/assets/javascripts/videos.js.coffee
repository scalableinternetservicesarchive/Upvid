# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# $.ready = ->
# 	$(".video-list-item").hover(
# 		(ev) -> 
# 			$(this).find(".video-title").show()

# 		(ev) -> 
# 			$(this).find(".video-title").hide()
# 	) 





# $ ->
#   if $('.video-list-wrapper').size() > 0
#     $(window).on 'scroll', ->
#       more_posts_url = $('.pagination a[rel=next]').attr('href')
#       if more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
#           $('.pagination').html("")
#           $.ajax
#             url: more_posts_url
#             success: (data) ->
#               $(".video-list-wrapper").append(data)
#       if !more_posts_url
#         $('.pagination').html("")
#     return