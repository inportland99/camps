# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#add date picker to contact time field

jQuery ->
  # $('#time').datetimepicker(
  #   minuteStepping:30,
  #   pickDate: false,
  #   icons:
  #     time: "fa fa-clock-o",
  #     date: "fa fa-calendar",
  #     up: "fa fa-arrow-up",
  #     down: "fa fa-arrow-down"

  $('#time').timepicker
    disableTimeRanges: [['7:30pm', '11:59pm'],['12:00am', '10:00am']]
