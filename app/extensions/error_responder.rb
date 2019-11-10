module ErrorResponder
  def self.included(base)
    base.rescue_from StandardError do |ex|
      render json: {message: ex.message}, status: :bad_request
    end
  end
end