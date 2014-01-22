# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#Calcualte total for selected camps.
jQuery ->
  if $(".camp_offerings").length > 0
    $(document).ready ->
      #collect params
      vars = []
      hash = undefined
      hashes = window.location.href.slice(window.location.href.indexOf("?") + 1).split("&")
      i = 0
      while i < hashes.length
        hash = hashes[i].split("=")
        vars.push hash[0]
        vars[hash[0]] = hash[1]
        i++

      #calculate total on page load (incase of redirect)
      total = 0
      $('input[type=checkbox]').each ->
        if $(this).is(":checked")
          total += $(this).data('price')

      #show modal questionaire on page load.
      if vars.questionaire
        $('#registrationModal').modal('show')

      #update total if camps are selected
      $('#registration_total > p').children('span').text("$#{total}.00")
      count = 0
      $('input[type=checkbox]').each ->
        if $(this).is(":checked")
          count += 1
          name = $(this).data('name')
          $("#camp_registrations ul").append("<li>#{name}</li>")
      if count < 1
        $("#camp_registrations ul").text("You have not selected any camps.")

  #questionaire modal
  $('#highlight').on 'click', ->
    $('#registrationModal').modal('hide')
    $('#confirmationModal').modal('show')

  #calculate total change of selection
  $('.registration_camp_offerings').on 'change', 'input[type="checkbox"]', ->
    total = 0
    $('input[type=checkbox]').each ->
      if $(this).is(":checked")
        total += $(this).data('price')
    $('#registration_total > p').children('span').text("$#{total}.00")
    $('#registration_button').val("Submit Registration $#{total}")

  #add selected camp to list for registration confirmation
  $('.registration_camp_offerings').on 'change', 'input[type="checkbox"]', ->
    $("#camp_registrations ul").text('')
    count = 0
    $('input[type=checkbox]').each ->
      if $(this).is(":checked")
        count += 1
        name = $(this).data('name')
        $("#camp_registrations ul").append("<li>#{name}</li>")
    if count < 1
      $("#camp_registrations ul").text("You have not selected any camps.")

  #toggle calendar view based on location select field
  $('#registration_location_id').trigger('blur') #lose focus to trigger .on 'change'
  $('#registration_location_id').on 'change', ->
    $('#powell_camp_offerings').css('display','none')
    $('#new_albany_camp_offerings').css('display','none')
    if $('#registration_location_id').val() is "1"
      $('#powell_camp_offerings').css('display','inline-block')
    if $('#registration_location_id').val() is "2"
      $('#new_albany_camp_offerings').css('display','inline-block')

jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  registration_payment.setupForm()

registration_payment =
  setupForm: ->
    $('#new_registration').submit ->
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
          registration_payment.processCard()
          false

  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    Stripe.createToken(card, registration_payment.handleStripeResponse)

  handleStripeResponse: (status, response) ->
    if status == 200
      str = $('#registration_total > p').children('span').text()
      str = str.replace(",","")
      str = str.replace("$","")
      amount = parseInt(str)
      $('#registration_stripe_card_token').val(response.id)
      $('#registration_total').val(amount)
      console.log $('#registration_total').val()
      if confirm('Your information has been validated. Click OK to complete the transaction (this will bill your card).')
        $('#new_registration')[0].submit()
      else
        false
        $('input[type=submit]').attr('disabled', false)
    else
      $('#stripe_error').text(response.error.message)
      # $('html, body').animate({scrollTop:0}, 'slow')
      $('#cc_field').addClass('has-error')
      $('input[type=submit]').attr('disabled', false)