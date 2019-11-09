class FileExtensionError < StandardError
  attr_reader :message

  def initialize(msg)
    @message = msg
    super
  end
end