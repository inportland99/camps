

if Rails.env.production?
  Stripe.api_key = ENV['STRIPE_API_KEY']
  STRIPE_PUBLIC_KEY = ENV['STRIPE_PUB_KEY']
else
  Stripe.api_key = "sk_test_rwrnOVYH3gfX6WyN5HmitOsN"
  STRIPE_PUBLIC_KEY = "pk_test_4iX39DyZ4s4CceDoLe7XU72W"
end
