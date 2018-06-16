require 'rails/generators/migration'

module Decider
  module Generators
    class OperationGenerator < ::Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      desc "generate a operation"
    end

    def check_installation
      raise 'Run rails generate decider:install first' unless File.exists?("#{Rails.root}/config/operations.yml")
    end

    def generate_operation

    end
  end
end