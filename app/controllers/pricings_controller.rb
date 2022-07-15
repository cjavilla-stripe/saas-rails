class PricingsController < ApplicationController
  before_action :authenticate_user!

  def show
  end

  def custom
    @prices = Stripe::Price.list(
      expand: ['data.product'],
      recurring: {
        interval: params.fetch(:interval, 'month'),
      },
      lookup_keys: [
        'startup',
        'startup_annual',
        'business',
        'business_annual',
        'enterprise',
        'enterprise_annual'
      ]
    ).data.sort_by(&:unit_amount)
  end
end
