# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#Calcualte total for selected camps.
jQuery ->

  if document.getElementById("facebook_pixel_tracking")
    total = $("#facebook_pixel_tracking").data('amount')
    fbq('track', 'Purchase', {value: total, currency: 'USD'});

  $('.reg-datatable').DataTable
    responsive: true,
    pagingType: 'simple'
    order:      [[ 0, "desc" ]]

  $registrationModal = $('#registrationModal')
  $inputCheckbox = $('input[type=checkbox]')

  if !(document.getElementById("camp_offerings") is null)
    $('.payment_plan_banner').delay(2000).fadeIn(1000)

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
  $mill_run_camp_offerings = $('#mill_run_camp_offerings')
  $past_camp_offerings = $('#past_il_camp_offerings')
  $teays_valley_camp_offerings = $('#teays_valley_camp_offerings')

  $registration_location_id.trigger('blur') #lose focus to trigger .on 'change'
  $registration_location_id.on 'change', ->
    $powell_camp_offerings.css('display','none')
    $new_albany_camp_offerings.css('display','none')
    $mill_run_camp_offerings.css('display','none')
    $past_camp_offerings.css('display','none')
    $teays_valley_camp_offerings.css('display', 'none')

    if $registration_location_id.val() is "1"
      $powell_camp_offerings.css('display','inline-block')
    if $registration_location_id.val() is "2"
      $new_albany_camp_offerings.css('display','inline-block')
    if $registration_location_id.val() is "3"
      $mill_run_camp_offerings.css('display','inline-block')
    if $registration_location_id.val() is "4"
      $past_camp_offerings.css('display','inline-block')
    if $registration_location_id.val() is "5"
      $teays_valley_camp_offerings.css('display','inline-block')

  #coupon code lookup logic
  $('#coupon_code_button').on 'click', ->
    $(this).attr('disabled', true)
    coupon_code.look_up()

  #Payment plan logic, **check box is hidden/shown via selected total method**
  fadeTime = 1000
  $('#payment_plan').on 'click', ->
    if $(this).is(':checked')
      $('#payment_plan_info').fadeIn(fadeTime)
      $('#installment_explanation').fadeOut(fadeTime)
      $('#payment_plan_amounts').fadeIn(fadeTime)
    else
      $('#payment_plan_info').fadeOut(fadeTime)
      $('#installment_explanation').fadeIn(fadeTime)
      $('#payment_plan_amounts').fadeOut(fadeTime)

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
        if !results['active']
          $coupon_error.text("Coupon Has Expired")
          $coupon_code.val('')
          $coupon_code_button.attr('disabled', false)
        if (results['name']=='MORECAMPS' && parseInt($('#registration_subtotal').attr('data-subtotal')) < 250)
          $coupon_error.text("At least 2 camps required")
          $coupon_code.val('')
          $coupon_code_button.attr('disabled', false)
        else
          $('#registration_subtotal').attr('data-coupon-name', results['name'])
          if results.coupon_type < 2 || results.coupon_type > 2 # if coupon is standard discount types
            $coupon_code_button.attr('disabled', false)
            $coupon_total_p.children('strong').text("Coupon Applied: ")
            $coupon_total_p.children('span').text("#{results.name}")
            $coupon_total.attr("data-amount", results.amount )
            $coupon_total.attr("data-coupon", results.coupon_type)
            $registration_coupon_code.val($coupon_code.val())
            $coupon_code.val('')
            camps.selected_total()
          else #if coupon amount varies between half and full day camps
            console.log results
            $coupon_code_button.attr('disabled', false)
            $coupon_total_p.children('strong').text("Coupon Applied: ")
            $coupon_total_p.children('span').text("#{results.name}")
            $coupon_total.attr("data-half-day-discount", results.half_day_discount )
            $coupon_total.attr("data-full-day-discount", results.full_day_discount )
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
    if count is 0
      $camp_registrations_ul.text("No camps selected yet.").css('color', 'red')

  selected_total: ->
    total = 0
    #loop through checked camps to calculate total
    $(':checkbox:checked', '#camp_offerings').each ->
      if $(this).is(":checked")
        total += $(this).data('price')
    coupon_type = parseInt($('#coupon_total').attr('data-coupon'))
    coupon_amount = parseInt($('#coupon_total').attr('data-amount'))
    coupon_half_day_discount = parseInt($('#coupon_total').attr('data-half-day-discount'))
    coupon_full_day_discount = parseInt($('#coupon_total').attr('data-full-day-discount'))
    camp_count = parseInt(camps.selectedCount())
    half_day_count = parseInt(camps.halfdayCount())
    full_day_count = parseInt(camps.fulldayCount())

    #update subtotal
    $('#registration_subtotal').children('span').text("$#{total}.00")
    $('#registration_subtotal').attr('data-subtotal', total)

    if coupon_type is 0
      amount = coupon_amount * camp_count
      if $('#registration_subtotal').attr('data-coupon-name') == 'MORECAMPS' && (parseInt($('#registration_subtotal').attr('data-subtotal')) < 250)
        amount = 0
      #populate discount div with discount information
      $('#registration_discount').children('strong').text("Discount: ")
      $('#registration_discount').children('span').text("-$#{amount}.00")
      #update total
      $('#registration_total > p').children('span').text("$#{total - amount}.00")
      total = total - amount
    else if coupon_type is 1
      inverse_percent_discount = (100 - coupon_amount)/100
      percent_discount =  (coupon_amount)/100
      discount_amount = Math.round((total - total * inverse_percent_discount) * 100)/100
      discount_amount = (discount_amount).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,')
      total_after_discount = (total * inverse_percent_discount).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,')
      #populate discount div with discount information
      $('#registration_discount').children('strong').text("Discount: ")
      $('#registration_discount').children('span').text("-$#{discount_amount}")
      #update total
      $('#registration_total > p').children('span').text("$#{total_after_discount}")
      total = total_after_discount
    else if coupon_type is 2
      discount_amount = (half_day_count * coupon_half_day_discount) + (full_day_count * coupon_full_day_discount)
      #populate discount div with discount information
      $('#registration_discount').children('strong').text("Discount: ")
      $('#registration_discount').children('span').text("-$#{discount_amount}.00")
      #update total
      $('#registration_total > p').children('span').text("$#{total - discount_amount}.00")
      total = total - discount_amount
    else if coupon_type is 3
      discount_amount = coupon_amount
      #populate discount div with discount information
      $('#registration_discount').children('strong').text("Discount: ")
      $('#registration_discount').children('span').text("-$#{discount_amount}.00")
      #update total
      $('#registration_total > p').children('span').text("$#{total - discount_amount}.00")
      total = total - discount_amount
    else
      #update total
      $('#registration_total > p').children('span').text("$#{total}.00")

    # Calculate and display payments with dates
    first_payment = Math.floor(total*100/3)/100
    second_payment = first_payment
    third_payment = Math.round((total - (first_payment + second_payment))*100)/100
    todays_date = moment().format('MMM Do, YYYY')
    thrity_days_out = moment().add(30, 'days').format('MMM Do, YYYY')
    sixty_days_out = moment().add(60, 'days').format('MMM Do, YYYY')

    $('#registration_payment_1').children('p').html("<strong>Payment 1: #{todays_date}</strong> - $#{first_payment.toFixed(2)} <span style='color:orange;'>(today)</span>")
    $('#registration_payment_2').children('p').html("<strong>Payment 2: #{thrity_days_out}</strong> - $#{second_payment.toFixed(2)}")
    $('#registration_payment_3').children('p').html("<strong>Payment 3: #{sixty_days_out}</strong> - $#{third_payment.toFixed(2)}")


    # Show/hide payment plan option if amount is above $250
    if total > 250
      $('#payment_plan_field').show()
    else
      $('#payment_plan_info').hide()
      $('#payment_plan_field').hide()
      $('#payment_plan').attr('checked', false)
      $('#payment_plan_amounts').fadeOut(800)

    # Show/hide second camp upsell option if amount is above $0 and <$250
    if (total > 0)&&(total < 250)
      $('#upsell_field').show()
    else
      $('#upsell_field').hide()

  selectedCount: ->
    # count selected camps less extended care options selected
    count = $(':checkbox:checked', '#camp_offerings').length - $('.extended-care:checked').length
    count

  halfdayCount: ->
    # count selected camps less extended care options selected
    half_day_camps = $('input[data-halfday="true"]', '#camp_offerings')
    count = 0
    for camp in half_day_camps
      if camp.checked
        count += 1

    count

  fulldayCount: ->
    # count selected camps less extended care options selected
    full_day_camps = $('input[data-halfday="false"]', '#camp_offerings')
    count = 0
    for camp in full_day_camps
      if camp.checked
        count += 1

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

    card_token = Stripe.createToken(card, registration_payment.handleStripeResponse)

  handleStripeResponse: (status, response) ->
    if status == 200
      registration_payment.amountUpdate()
      $('#registration_stripe_card_token').val(response.id)
      if confirm('Your information has been validated. Click OK to complete the transaction (this will bill your card).')
        $('#new_registration')[0].submit()
      else
        false
        $('input[type=submit]').attr('disabled', false)
    else
      $('#stripe_error').text(response.error.message)
      $('#cc_field').addClass('has-error')
      $('input[type=submit]').attr('disabled', false)
