class DashboardsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_subscribed!

  def show
  end
end
