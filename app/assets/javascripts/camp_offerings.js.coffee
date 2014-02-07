# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#registration index table datatables
  responsiveHelper = undefined
  breakpointDefinition =
    tablet: 1024
    phone: 480
  tableContainer = $('.datatable_offering')

  tableContainer.dataTable
    sPaginationType: "bootstrap"
    # Setup for responsive datatables helper.
    bSort: false
    bAutoWidth: false
    bStateSave: false

    fnPreDrawCallback: ->
      responsiveHelper = new ResponsiveDatatablesHelper(tableContainer, breakpointDefinition) unless responsiveHelper

    fnRowCallback: (nRow, aData, iDisplayIndex, iDisplayIndexFull) ->
      responsiveHelper.createExpandIcon nRow

    fnDrawCallback: (oSettings) ->
      responsiveHelper.respond()