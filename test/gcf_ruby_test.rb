# frozen_string_literal: true

require 'test_helper'

# Main test class
class GcfRubyTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::GcfRuby::VERSION
  end

  def test_correct_prediction
    VCR.use_cassette('good_machine_learning_api_requests') do
      response = GcfRuby.predict_async('classification_diags',
                                       [{ url: 'https://test.pdf', doc_id: 1 }],
                                       'https://www.webhookdummyurl.com')
      assert response
    end
  end
end
