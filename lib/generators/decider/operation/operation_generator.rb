require 'rails/generators'
require 'pry'
module Decider
  module Generators
    class OperationGenerator < Rails::Generators::Base


      source_root File.expand_path('../templates', __FILE__)
      desc "generate a operation"

      def check_installation
        raise 'Run rails generate nayati:install first' unless File.exists?("#{Rails.root}/config/operations.yml")
      end

      def generate_operation
        raise "Operation and workflow name must be passed" unless args.size == 2
        workflow_name = args.first
        operation_name = args.last

        workflow_namespace = Decider::NameBasedConstantable.underscored_name(workflow_name)
        operation_namespace = Decider::NameBasedConstantable.underscored_name(operation_name)

        master_worflow = Decider::MasterWorkflow.new(workflow_name)
        raise 'Please generate workflow first' unless master_worflow.exists?
        # make entry in operations.yml

        master_operation = Decider::MasterOperation.new(master_worflow, operation_name)

        raise 'Operation already exists' if master_operation.exists?

        master_operation.save

        # create operation implementer class
        workflow_constant_name = Decider::NameBasedConstantable.name_as_constant(workflow_namespace)
        operation_constant_name = Decider::NameBasedConstantable.name_as_constant(operation_namespace)

        operation_file_path = "#{Rails.root}/app/nayati_operations/#{workflow_namespace}_nayati_workflow/#{operation_namespace}_nayati_operation.rb"


        copy_file "operation_template.txt", operation_file_path
        inject_into_file operation_file_path, " #{workflow_constant_name}DeciderWorkflow", after: 'module'
        inject_into_file operation_file_path, "#{operation_constant_name}DeciderOperation ", after: 'class '
      end
    end
  end
end
