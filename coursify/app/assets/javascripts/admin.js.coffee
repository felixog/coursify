# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
	$('#sections').sortable
		axis: "y"
		update: ->
			$.post($(this).data('update-url'), $(this).sortable('serialize'))

	$('#lessons').sortable
		axis: "y"
		update: ->			
			$.post($(this).data('update-url'), $(this).sortable('serialize'))
