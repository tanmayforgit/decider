module Nayati
  class MasterWorkflow
    attr_reader :name
    def initialize(name)
      @name = name
      @errors = []
      @operation_addition_errors = []
      @name_as_sym = @name.to_sym
    end

    def operation_names
      Nayati::OperationConfiguration.operation_names(self.name)
    end

    def add_operation(operation_name)
      Nayati::OperationConfiguration.add_operation_unless_present(self.name, operation_name)
    end

    def save!
      Nayati::OperationConfiguration.add_workflow_unless_present(self.name)
    end

    def exists?
      Nayati::OperationConfiguration.workflow_names.include?(@name_as_sym)
    end

    def valid?
      validate_name
      @errors.empty?
    end

    def valid_to_add_operation?(operation_name)
      validate_operation_uniqueness(operation_name)
      @operation_addition_errors.empty?
    end

    class << self
      def all_workflow_names
        Nayati::OperationConfiguration.workflow_names
      end

    end

    def error_message
      @errors.join(', ')
    end

    def operation_addition_error_message
      @operation_addition_errors.join(', ')
    end

    private

    def validate_operation_uniqueness(operation_name)
      @operation_addition_errors << 'Already exists' if operation_exists?(operation_name)
    end

    def operation_exists?(operation_name)
      operation_namespace = ::Nayati::NameBasedConstantable.name_as_namespace(operation_name.to_s)
      operation_names.include?(operation_namespace)
    end

    def validate_name
      @errors << 'Name already exists' if Nayati::OperationConfiguration.workflow_exists?(self.name)
    end
  end
end