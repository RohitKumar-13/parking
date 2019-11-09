class RetryLimitReached < StandardError
  attr_reader :message

  def initialize
    @message = I18n.t('errors.retry_limit_reached')
    super
  end
end