require 'rails/generators'
require 'pry'
module Decider
  module Generators
    class WorkflowGenerator < Rails::Generators::Base


      source_root File.expand_path('../templates', __FILE__)
      desc "generate a operation"

      def check_installation
        raise 'Run rails generate decider:install first' unless File.exists?("#{Rails.root}/config/operations.yml")
      end

      def generate_workflow
        raise "Workflow name must be passed" unless args.size == 1
        workflow_name = args.first

        underscored_workflow_name = Decider::NameBasedConstantable.underscored_name(workflow_name)

        master_workflow = Decider::MasterWorkflow.new(underscored_workflow_name)

        raise 'Workflow already exists' if master_workflow.exists?

        # make entry in operations.yml
        master_workflow.save!

        # Create workflow directory
        FileUtils.mkdir_p("#{Rails.root}/decider_workflows/#{underscored_workflow_name}")
      end
    end
  end
end
