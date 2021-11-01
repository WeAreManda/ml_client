# frozen_string_literal: true

# Ruby bindings
require 'json'
require 'net/http'

# Resource and support classes
require 'ml_client/version'
require 'ml_client/errors'

# Main class for prediction
module MLClient
  class << self
    attr_accessor :configuration

    def predict(model_name, instances, url: api_url, endpoint: nil)
      endpoint ||= 'predict'
      query_strings = { model: model_name }
      post(url, endpoint, query_strings, formatted_instances(instances))
    end

    def predict_async(model_name, instances, url: api_url, endpoint: nil, webhook_url: nil)
      endpoint ||= 'predict_async'
      query_strings = { model: model_name, webhook_url: webhook_url }
      post(url, endpoint, query_strings, formatted_instances(instances))
    end

    def configure
      self.configuration ||= Configuration.new
      yield configuration
    end

    def api_url
      configuration&.api_url
    end

    private

    def post(url, endpoint, query_strings, payload)
      raise ConfigurationError, 'Missing url' if url.nil?

      uri = URI.join(url, endpoint || '')
      uri.query = URI.encode_www_form(query_strings)

      req = Net::HTTP::Post.new(uri)
      req['Authorization'] = "Bearer #{configuration.api_bearer}" if configuration&.api_bearer
      req['Content-Type'] = 'application/json'

      req.body = payload.to_json
      generate_https = Net::HTTP.new(uri.host, uri.port)
      generate_https.use_ssl = true
      generate_https.set_debug_output($stdout) if configuration&.debug

      res = generate_https.request(req)
      response = JSON.parse(res.body)

      case res.code
      when '400'
        raise FailedValidationError, "Wrong inputs #{params} in model #{model_name}"
      when '403'
        raise AuthentificationError, 'Authorization error'
      when '404'
        raise WrongModelName, "Wrong model name #{model_name}"
      when '405'
        raise AsyncError, "#{model_name} should be called in an asynchronous manner"
      when '500'
        raise InternalServerError, 'Internal server error in api'
      when '200'
        # it's sync
        response
      when '202'
        # it's async
        true
      else
        raise UnhandledError, 'Cannot process error code'
      end
    end

    def formatted_instances(params)
      { instances: params }
    end
  end

  # Configuration for client
  class Configuration
    attr_accessor :api_url
    attr_accessor :api_bearer
    attr_accessor :debug

    def initialize
      @debug = false
    end
  end
end
