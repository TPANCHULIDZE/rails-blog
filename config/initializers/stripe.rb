Rails.configuration.stripe = {
  published_key: Rails.application.credentials.production[:stripe_published_key],
  secret_key: Rails.application.credentials.production[:stripe_secret_key]
}

Stripe.api_key = Rails.application.credentials.production[:stripe_secret_key]