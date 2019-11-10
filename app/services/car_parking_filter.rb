class CarParkingFilter
  PER_PAGE = 20

  attr_accessor :car_parkings, :params

  def initialize(params)
    @car_parkings = CarParking.available
    @params = params
  end

  def filter
    order_by_nearest
    paginate
    self
  end

  private

  def order_by_nearest
    self.car_parkings = car_parkings.order_by_nearest_to(params[:latitude], params[:longitude])
  end

  def paginate
    page = (params[:page] || 1).to_i
    per_page = (params[:per_page] || PER_PAGE).to_i
    self.car_parkings = self.car_parkings.limit(per_page).offset([page - 1, 0].max * per_page)
  end
end