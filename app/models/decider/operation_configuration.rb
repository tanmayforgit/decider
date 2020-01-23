module Decider
  module OperationConfiguration
    class << self
      def configuration
        @configuration ||= YAML.load(File.open(yaml_file_path)) || {}
      end

      def operation_names(workflow_name)
        wf_name = ::Decider::NameBasedConstantable.name_as_namespace(workflow_name.to_s)
        (configuration[wf_name.to_sym] || []).map { |operation_conf| operation_conf.try(:[], :name) }
      end

      def add_workflow_unless_present(workflow_name)
        wf_namespace = ::Decider::NameBasedConstantable.name_as_namespace(workflow_name.to_s)
        unless workflow_names.include?(wf_namespace.to_sym)
          configuration[wf_namespace.to_sym] = []
          write_configuration
        end
      end

      def add_operation_unless_present(workflow_name, operation_name)
        wf_namespace = ::Decider::NameBasedConstantable.name_as_namespace(workflow_name.to_s)
        op_namespace = ::Decider::NameBasedConstantable.name_as_namespace(operation_name.to_s)

        add_workflow_unless_present(wf_namespace)

        unless operation_names(wf_namespace).include?(op_namespace)
          configuration[wf_namespace.to_sym] << { name: op_namespace }
          write_configuration
        end
      end

      def workflow_exists?(workflow_name)
        wf_namespace = ::Decider::NameBasedConstantable.name_as_namespace(workflow_name.to_s)
        workflow_names.include?(wf_namespace.to_sym)
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

      def update_operation(workflow_name, old_name, new_name)
        op_conf = operation_configuration(workflow_name, old_name)

        op_conf[:name] = ::Decider::NameBasedConstantable.name_as_namespace(new_name.to_s)
        write_configuration
      end

      private

      def operation_configuration(workflow_name, operation_name)
        wf_namespace = ::Decider::NameBasedConstantable.name_as_namespace(workflow_name.to_s)
        op_namespace = ::Decider::NameBasedConstantable.name_as_namespace(operation_name.to_s)

        wf_conf = workflow_configuration(wf_namespace)
        wf_conf.detect { |operation| operation[:name] == op_namespace }

      end

      def workflow_configuration(workflow_namespace)
        configuration[workflow_namespace.to_sym]
      end
    end
  end
end
