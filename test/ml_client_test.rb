# frozen_string_literal: true

require 'test_helper'

# Main test class
class MLClientTest < Minitest::Test
  def test_that_it_has_a_version_number
    assert_not_nil ::MLClient::VERSION
  end

  def test_correct_prediction
    VCR.use_cassette('good_machine_learning_api_requests') do
      response = MLClient.predict_async('classification_diags',
                                        [{ url: 'https://test.pdf', doc_id: 1 }],
                                        'https://www.webhookdummyurl.com')
      assert response
    end
  end
end