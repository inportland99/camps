//= require jquery
//= require jquery_ujs
//= require init
//= require chosen-jquery
//= require jquery.remotipart
//= require jquery_nested_form
//= require jquery-ui
//= require jquery.html5-placeholder-shim
//= require jquery.timepicker.js
//= require camp_surveys
//= require coupon_codes
//= require tether
//= require bootstrap
//= require datatables
//= require moment
//= require underscore
//= require pages
//= require registrations

jQuery ->
  $('.datatable').DataTable
    responsive: true,
    pagingType: 'simple'
    order:      [[ 0, "desc" ]]

  $('.datepicker').datepicker
    dateFormat: "yy-mm-dd",
    changeMonth: true,
    changeYear: true

  $('.chosen').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'
