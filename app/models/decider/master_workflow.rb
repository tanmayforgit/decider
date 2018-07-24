module Decider
  class MasterWorkflow
    attr_reader :name
    def initialize(name)
      @name = name
      @errors = []
    end

    def operation_names
      Decider::OperationConfiguration.operation_names(self.name)
    end

    def add_operation(operation_name)
      Decider::OperationConfiguration.add_operation_unless_present()
    end

    def save!
      Decider::OperationConfiguration.add_workflow_unless_present(self.name)
    end

    def valid?
      validate_name
      @errors.empty?
    end

    class << self
      def all_workflow_names
        Decider::OperationConfiguration.workflow_names
      end

    end

    def error_message
      @errors.join(', ')
    end

    private

    def validate_name
      @errors << 'Name already exists' if Decider::OperationConfiguration.workflow_exists?(self.name)
    end
  end
end