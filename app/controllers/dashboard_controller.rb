class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    flash.now[:notice] = {
      title: "TEST",
      body: "TEST"
    }
  end
end
