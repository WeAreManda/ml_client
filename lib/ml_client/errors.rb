# frozen_string_literal: true

module MLClient
  # MLClient is the base error from which all other more specific errors
  class MLClient < StandardError
    attr_accessor :message

    def initialize(message = nil)
      @message = message
      super
    end
  end

  # in case of 400
  class FailedValidationError < MLClient
  end

  # in case of 403
  class AuthentificationError < MLClient
  end

  # in case of 404
  class WrongModelName < MLClient
  end

  # in case of 405
  class AsyncError < MLClient
  end

  # in case of 500
  class InternalServerError < MLClient
  end

  # in case of configuration errors
  class ConfigurationError < MLClient
  end

  # in case of other errors
  class UnhandledError < MLClient
  end
end
