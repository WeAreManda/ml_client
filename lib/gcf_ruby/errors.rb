# frozen_string_literal: true

module GcfRuby
  # GcfError is the base error from which all other more specific errors
  class GcfError < StandardError
    attr_accessor :message

    def initialize(message = nil)
      @message = message
    end
  end

  # in case of 400
  class FailedValidationError < GcfError
  end

  # in case of 403
  class AuthentificationError < GcfError
  end

  # in case of 404
  class WrongModelName < GcfError
  end

  # in case of 405
  class AsyncError < GcfError
  end

  # in case of 500
  class InternalServerError < GcfError
  end

  # in case of other errors
  class UnhandledError < GcfError
  end
end
