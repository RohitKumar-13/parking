class ApplicationController < ActionController::API
  include ErrorResponder
  include ControllerActionParamsValidator

  before_action :validate_controller_action_params!
end
