class User < ApplicationRecord
  pay_customer(
    default_payment_processor: :stripe,
    stripe_attributes: :stripe_attributes
  )

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  def stripe_attributes(pay_customer)
    attrs = {
      description: "Created with pay",
      metadata: {
        pay_customer_id: pay_customer.id,
        user_id: id
      }
    }

    if Rails.env.development?
      clock = Stripe::TestHelpers::TestClock.create(
        frozen_time: Time.now.to_i
      )
      attrs[:test_clock] = clock.id
    end

    attrs
  end

  # before_validation :ensure_stripe_customer
  #
  # def ensure_stripe_customer
  #   customer = Stripe::Customer.create(email: self.email)
  #   self.update(stripe_customer_id: customer.id)
  # end
end
