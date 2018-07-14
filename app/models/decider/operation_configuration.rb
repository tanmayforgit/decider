module Decider
  class OperationConfiguration
    def initialize
      @configuration = YAML.load(File.open("#{Rails.root}/config/operations.yml")) || {}
    end

    def workflow_names
      @configuration.keys
    end

    def operations(workflow_name)
      namespace = Decider::NameBasedConstantable.name_as_namespace(workflow_name)

      @configuration[namespace]
    end
  end
end
