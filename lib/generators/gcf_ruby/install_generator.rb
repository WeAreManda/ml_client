# frozen_string_literal: true

module GcfRuby
  module Generators
    # Install Generator inherits from Rails::Generator::Base
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../../templates', __dir__)
      desc 'Creates GcfRuby initializer for your application'

      def copy_initializer
        template 'gcf_initializer.rb', 'config/initializers/gcf_ruby.rb'

        puts 'Install complete!'
      end
    end
  end
end
