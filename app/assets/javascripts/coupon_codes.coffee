jQuery ->
  $('#coupon_code_coupon_type').on 'change', ->
    if $(this).val() < 2 || $(this).val() > 2
      $('.coupon_code_amount').show()
      $('.coupon_code_half_day_discount').hide()
      $('#coupon_code_half_day_discount').val('')
      $('.coupon_code_full_day_discount').hide()
      $('#coupon_code_full_day_discount').val('')
    else
      $('.coupon_code_half_day_discount').show()
      $('.coupon_code_full_day_discount').show()
      $('.coupon_code_amount').hide()
      $('#coupon_code_amount').val('')
