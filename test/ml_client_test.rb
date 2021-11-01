# frozen_string_literal: true

require 'test_helper'

# Main test class
class MLClientTest < Minitest::Test
  def test_that_it_has_a_version_number
   refute_nil ::MLClient::VERSION
  end

  def test_correct_prediction
    VCR.use_cassette('good_machine_learning_api_requests') do
      response = MLClient.predict_async('classification_diags',
                                        [{ url: 'https://test.pdf', doc_id: 1 }],
                                        webhook_url: 'https://www.webhookdummyurl.com')
      assert response
    end
  end
end
