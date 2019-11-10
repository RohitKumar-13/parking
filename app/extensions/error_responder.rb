module ErrorResponder
  def self.included(base)
    base.rescue_from StandardError do |ex|
      Rails.logger.info ex.message
      Rails.logger.info ex.backtrace
      render json: {message: ex.message}, status: :bad_request
    end
  end
end