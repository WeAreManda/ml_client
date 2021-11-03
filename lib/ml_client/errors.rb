# frozen_string_literal: true

module MLClient
  # MLClient is the base error from which all other more specific errors
  class MLClientError < StandardError
    attr_accessor :message

    def initialize(message = nil)
      @message = message
      super
    end
  end

  # in case of 400
  class FailedValidationError < MLClientError
  end

  # in case of 403
  class AuthentificationError < MLClientError
  end

  # in case of 404
  class WrongModelName < MLClientError
  end

  # in case of 405
  class AsyncError < MLClientError
  end

  # in case of 500
  class InternalServerError < MLClientError
  end

  # in case of configuration errors
  class ConfigurationError < MLClientError
  end

  # in case of other errors
  class UnhandledError < MLClientError
  end
end
