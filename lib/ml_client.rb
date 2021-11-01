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

    def predict(model_name, params)
      post(model_name, formatted_params(params))
    end

    def predict_async(model_name, params, webhook_url)
      post(model_name, formatted_params(params), webhook_url)
    end

    def configure
      self.configuration ||= Configuration.new
      yield configuration
    end

    private

    def post(model_name, params, url = nil)
      uri = URI.parse(self.configuration.api_url)
      query_params = { model: model_name }
      query_params[:url] = url if url
      uri.query = URI.encode_www_form(query_params)

      req = Net::HTTP::Post.new(uri)
      req['Authorization'] = "Bearer #{self.configuration.api_bearer}"
      req['Content-Type'] = 'application/json'

      req.body =  params.to_json
      generate_https = Net::HTTP.new(uri.host, uri.port)
      generate_https.use_ssl = true

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

    def formatted_params(params)
      { instances: params }
    end
  end

  # Configuration for client
  class Configuration
    attr_accessor :api_url
    attr_accessor :api_bearer

    def initialize
      @api_url = 'default option'
      @api_bearer = 'default option'
    end
  end
end
