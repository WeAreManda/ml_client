# frozen_string_literal: true

module MLClient
  module Generators
    # Install Generator inherits from Rails::Generator::Base
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../../templates', __dir__)
      desc 'Creates MLClient initializer for your application'

      def copy_initializer
        template 'ml_client_initializer.rb', 'config/initializers/ml_client.rb'

        puts 'Install complete!'
      end
    end
  end
end
