class RequiredParamsMissingError < StandardError
  attr_reader :message

  def initialize(keys)
    @message = I18n.t('errors.required_params_missing_for_api', keys: "`#{keys.join('`,`')}`")
    super
  end
end