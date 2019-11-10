class CarparksController < ApplicationController
  def nearest
    @parkings = CarParkingFilter.new(carparks_params).filter
  end

  private

  def carparks_params
    params.permit(:latitude, :longitude, :per_page, :page)
  end
end
