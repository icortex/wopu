# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#foundation_form select#foundation_available_tag_ids').chosen()

  $('.chosen-container ul').addClass 'form-control'
