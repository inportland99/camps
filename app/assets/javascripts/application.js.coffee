//= require jquery
//= require jquery_ujs
//= require init
//= require chosen-jquery
//= require jquery.remotipart
//= require jquery_nested_form
//= require jquery-ui
//= require jquery.html5-placeholder-shim
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require dataTables/extras/dataTables.responsive
//= require bootstrap/modal
//= require bootstrap/dropdown
//= require bootstrap/scrollspy
//= require bootstrap/tab
//= require bootstrap/tooltip
//= require bootstrap/popover
//= require bootstrap/collapse
//= require bootstrap/carousel
//= require bootstrap/alert
//= require moment
//= require bootstrap-datetimepicker
//= require underscore
//= require pages
//= require gritter
//= require registrations
//= require camp_surveys
//= require camp_offerings

jQuery ->
  $('.datatable').DataTable
    responsive: true,
    pagingType: 'simple'
    order:      [[ 0, "desc" ]]

  $('.datepicker').datepicker
    dateFormat: "yy-mm-dd"

  $('.chosen').chosen()
