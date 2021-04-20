# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../../lib', __dir__)

require 'gcf_ruby'
require 'minitest/autorun'
require 'vcr'

GcfRuby.configure do |config|
  config.api_url = 'https://europe-west1-flatlooker-bigquery.cloudfunctions.net/interface'
  config.api_bearer = 'fake_bearer'
end

VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = true
  config.cassette_library_dir = 'test/vcr_fixtures'
  config.hook_into :webmock
end
