class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  def show
    current_user.payment_processor.customer

    checkout_session = Stripe::Checkout::Session.create(
      mode: 'subscription',
      customer: current_user.payment_processor.processor_id,
      line_items: [{
        price: params[:price_id],
        quantity: 1
      }],
      success_url: root_url,
      cancel_url: root_url,
      automatic_tax: { enabled: true },
      customer_update: { address: 'auto' },
      metadata: {
        user_id: current_user.id,
      },
      subscription_data: {
        metadata: {
          user_id: current_user.id,
        },
      },
      allow_promotion_codes: true
    )

    redirect_to checkout_session.url, allow_other_host: true, status: :see_other
  end
end
