class LocationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @locations = Location.includes(:user)
  end
end
