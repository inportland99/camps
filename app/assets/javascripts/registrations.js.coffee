# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  registration_payment.setupForm()

registration_payment =
  setupForm: ->
    $('#new_registration').submit ->
      $('input[type=submit]').attr('disabled', true)
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
      $('#registration_stripe_card_token').val(response.id)
      $('#new_registration')[0].submit()
    else
      $('#stripe_error').text(response.error.message)
      $('html, body').animate({scrollTop:0}, 'slow')
      $('#cc_field').addClass('has-error')
      $('input[type=submit]').attr('disabled', false)