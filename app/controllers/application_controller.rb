class ApplicationController < ActionController::Base

  def ensure_subscribed!
    if !current_user.payment_processor.subscribed?
      redirect_to '/pricing'
    end
  end
end
