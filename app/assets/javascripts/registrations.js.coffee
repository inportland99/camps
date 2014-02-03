# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#Calcualte total for selected camps.
jQuery ->
  $registrationModal = $('#registrationModal')
  $inputCheckbox = $('input[type=checkbox]')

  if $(".camp_offerings").length > 0
    $(document).ready ->
      #collect params
      params = []
      hash = undefined
      hashes = window.location.href.slice(window.location.href.indexOf("?") + 1).split("&")
      i = 0
      while i < hashes.length
        hash = hashes[i].split("=")
        params.push hash[0]
        params[hash[0]] = hash[1]
        i++

      #calculate total on page load (incase of redirect)
      camps.selected_total()

      #update total if camps are selected
      camps.selected_camps()

  #questionaire modal
  $('#highlight').on 'click', ->
    $registrationModal.modal('hide')
    $('#confirmationModal').modal('show')

  #calculate total on change of selection
  $registration_camp_offerings = $('.registration_camp_offerings')
  $registration_camp_offerings.on 'change', 'input[type="checkbox"]', ->
    camps.selected_total()
    camps.selectedCount()

  #add selected camp to list for registration confirmation
  $registration_camp_offerings.on 'change', 'input[type="checkbox"]', ->
    camps.selected_camps()

  #toggle calendar view based on location select field
  $registration_location_id = $('#registration_location_id')
  $powell_camp_offerings = $('#powell_camp_offerings')
  $new_albany_camp_offerings = $('#new_albany_camp_offerings')

  $registration_location_id.trigger('blur') #lose focus to trigger .on 'change'
  $registration_location_id.on 'change', ->
    $powell_camp_offerings.css('display','none')
    $new_albany_camp_offerings.css('display','none')
    if $registration_location_id.val() is "1"
      $powell_camp_offerings.css('display','inline-block')
    if $registration_location_id.val() is "2"
      $new_albany_camp_offerings.css('display','inline-block')

  #coupon code lookup logic
  $('#coupon_code_button').on 'click', ->
    $(this).attr('disabled', true)
    coupon_code.look_up()

  #registration index table datatables
  responsiveHelper = undefined
  breakpointDefinition =
    tablet: 1024
    phone: 480
  tableContainer = $('.datatable')

  tableContainer.dataTable
    sPaginationType: "bootstrap"
    # Setup for responsive datatables helper.
    bAutoWidth: false
    bStateSave: false

    fnPreDrawCallback: ->
      responsiveHelper = new ResponsiveDatatablesHelper(tableContainer, breakpointDefinition) unless responsiveHelper

    fnRowCallback: (nRow, aData, iDisplayIndex, iDisplayIndexFull) ->
      responsiveHelper.createExpandIcon nRow

    fnDrawCallback: (oSettings) ->
      responsiveHelper.respond()


coupon_code =
  look_up: ->
    $coupon_code_button = $('#coupon_code_button')
    $coupon_total_p = $('#coupon_total > p')
    $coupon_total = $('#coupon_total')
    $coupon_error = $('#coupon_error')
    $coupon_code = $('#coupon_code')
    $registration_coupon_code = $('#registration_coupon_code')
    $coupon_error.text("")
    $.ajax
      type: 'POST'
      url: '/coupon_codes/code_lookup'
      data: code_name: $coupon_code.val()
      error: (xhr) ->
        console.log xhr
        $coupon_error.text("Coupon #{xhr.statusText}")
        $coupon_code.val('')
        $coupon_code_button.attr('disabled', false)
      success: (data) ->
        results = data # active:boolean, amount:int, coupon_type:intstring (0 $ off, 1 % off), description:text, id:int
        $coupon_code_button.attr('disabled', false)
        $coupon_total_p.children('b').text("Coupon Applied: ")
        $coupon_total_p.children('span').text("#{results.name}")
        $coupon_total.attr("data-amount", results.amount )
        $coupon_total.attr("data-coupon", results.coupon_type)
        $registration_coupon_code.val($coupon_code.val())
        $coupon_code.val('')
        camps.selected_total()

camps =
  selected_camps: ->
    $camp_registrations_ul = $("#camp_registrations ul")
    $camp_registrations_ul.text('')
    count = 0
    $(':checkbox:checked', '#camp_offerings').each ->
      count += 1
      name = $(this).data('name')
      $camp_registrations_ul.append("<li>#{name}</li>")
    if count < 1
      $camp_registrations_ul.text("You have not selected any camps.")

  selected_total: ->
    total = 0
    #loop through checked camps to calculate total
    $('input[type=checkbox]').each ->
      if $(this).is(":checked")
        total += $(this).data('price')
    coupon_type = parseInt($('#coupon_total').attr('data-coupon'))
    coupon_amount = parseInt($('#coupon_total').attr('data-amount'))
    camp_count = parseInt(camps.selectedCount())
    #update subtotal
    $('#registration_subtotal').children('span').text("$#{total}.00")

    if coupon_type is 0
      amount = coupon_amount * camp_count
      #populate discount div with discount information
      $('#registration_discount').children('b').text("Discount: ")
      $('#registration_discount').children('span').text("-$#{amount}.00")
      #update total
      $('#registration_total > p').children('span').text("$#{total - amount}.00")
    else if coupon_type is 1
      inverse_percent_discount = (100 - coupon_amount)/100
      percent_discount =  (coupon_amount)/100
      discount_amount = Math.round((total - total * inverse_percent_discount) * 100)/100
      discount_amount = (discount_amount).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,')
      total_after_discount = (total * inverse_percent_discount).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,')
      #populate discount div with discount information
      $('#registration_discount').children('b').text("Discount: ")
      $('#registration_discount').children('span').text("-$#{discount_amount}")
      #update total
      $('#registration_total > p').children('span').text("$#{total_after_discount}")
    else
      #update total
      $('#registration_total > p').children('span').text("$#{total}.00")

  selectedCount: ->
    count = $(':checkbox:checked', '#camp_offerings').length
    count


#stripe payment logic and form submition
jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  registration_payment.setupForm()

registration_payment =
  setupForm: ->
    $('#new_registration').submit ->
      registration_payment.amountUpdate()
      if $('#process_without_payment').is(":checked")
        true
      else
        $('input[type=submit]').attr('disabled', true)
        i = 0
        $('input[type=checkbox]').each ->
          if $(this).is(":checked")
            i += 1
        if i is 0
          alert "You must select a camp before registering."
          $('input[type=submit]').attr('disabled', false)
          false
        else
          if $('#card_number').val()
            registration_payment.processCard()
            false
          else if not $('#card_number').val() and $('#registration_stripe_card_token').val()
            true
          else
            alert "You have not entered a credit card."
            $('input[type=submit]').attr('disabled', false)
            false

  amountUpdate: ->
    str = $('#registration_total > p').children('span').text()
    str = str.replace(",","")
    str = str.replace("$","")
    str = str.replace(".","")
    amount = parseInt(str)
    $('#registration_total').val(amount)

  processCard: ->
    card =
      name: $('#registration_parent_first_name').val() + ' ' + $('#registration_parent_last_name').val()
      address_line1: $('#registration_parent_address_1').val()
      address_city: $('#registration_parent_city').val()
      address_state: $('#registration_parent_state').val()
      address_zip: $('#registration_parent_zip').val()
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    Stripe.createToken(card, registration_payment.handleStripeResponse)

  handleStripeResponse: (status, response) ->
    if status == 200
      registration_payment.amountUpdate()
      $('#registration_stripe_card_token').val(response.id)
      console.log $('#registration_total').val()
      if confirm('Your information has been validated. Click OK to complete the transaction (this will bill your card).')
        $('#new_registration')[0].submit()
      else
        false
        $('input[type=submit]').attr('disabled', false)
    else
      $('#stripe_error').text(response.error.message)
      $('#cc_field').addClass('has-error')
      $('input[type=submit]').attr('disabled', false)