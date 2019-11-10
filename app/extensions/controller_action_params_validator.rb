module ControllerActionParamsValidator
  private
  def validate_controller_action_params!
    action_keys = CONTROLLER_PARAMS_VALIDATION[params[:controller]].try(:[], params[:action])
    return if action_keys.blank?

    remaing_keys = action_keys - params.keys
    return if remaing_keys.blank?
    raise RequiredParamsMissingError.new(remaing_keys)
  end
end