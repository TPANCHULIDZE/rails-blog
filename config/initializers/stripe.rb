Rails.configuration.stripe = {
  published_key: Rails.application.credentials.development[:stripe_published_key],
  secret_key: Rails.application.credentials.development[:stripe_secret_key]
}

Stripe.api_key = Rails.application.credentials.development[:stripe_secret_key]