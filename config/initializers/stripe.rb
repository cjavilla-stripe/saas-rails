Stripe.api_key = Rails.application.credentials.dig(:stripe, :private_key)

# This could also be where you define the class with `class FulfillCheckout`
fulfill_checkout = -> (event) {
  puts "my handler !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
  checkout_session = event.data.object
  if checkout_session.customer && checkout_session.client_reference_id
    pay_customer = Pay::Customer.find_by(processor_id: checkout_session.customer)
    puts "pay customer: #{pay_customer}"
    if pay_customer.nil?
      user = User.find_by(id: checkout_session.client_reference_id)
      puts "user: #{user}"
      if !user.nil?
        customer = Pay::Customer.create!(
          owner: user,
          processor: :stripe,
          processor_id: checkout_session.customer,
          default: true,
        )
        subscription = Pay::Subscription.create!(
          customer: customer,
          processor_id: checkout_session.subscription
        )
        subscription.sync!
      else
        Rails.logger.error("Unknown user with client_reference_id: #{ event.data.object.client_reference_id }")
      end
    end
  end
}

Pay::Webhooks.delegator.subscribe "stripe.checkout.session.completed", fulfill_checkout
