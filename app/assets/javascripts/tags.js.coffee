# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#nonprofit_form select#nonprofit_available_tag_ids').chosen()

  $('.chosen-container ul').addClass 'form-control'
