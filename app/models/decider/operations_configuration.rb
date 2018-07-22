module Decider
  module OperationsConfiguration
    class << self
      def configuration
        @configuration ||= YAML.load(File.open(yaml_file_path)) || {}
      end

      def operation_names(workflow_name)
        wf_name = ::Decider::NameBasedConstantable.name_as_namespace(workflow_name.to_s)
        (configuration[wf_name.to_sym] || []).map { |operation_conf| operation_conf.try(:[], :name) }
      end

      def add_workflow_unless_present(workflow_namespace)
        unless workflow_names.include?(workflow_namespace.to_sym)
          configuration[workflow_namespace.to_sym] = []
        end
      end

      def add_operation_unless_present(workflow_name, operation_name)
        wf_namespace = ::Decider::NameBasedConstantable.name_as_namespace(workflow_name.to_s)
        op_namespace = ::Decider::NameBasedConstantable.name_as_namespace(operation_name.to_s)

        add_workflow_unless_present(wf_namespace)

        unless operation_names(wf_namespace).include?(op_namespace)
          configuration[wf_namespace.to_sym] << { name: op_namespace, end_point: nil }
          write_configuration
        end
      end

      def yaml_file_path
        "#{Rails.root}/config/operations.yml"
      end

      def write_configuration
        File.open(yaml_file_path, 'w') { |f| f.write configuration.to_yaml }
      end

      def workflow_names
        configuration.keys
      end
    end
  end
end
