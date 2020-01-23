module Decider
  class MasterOperation
    attr_reader :name
    def initialize(master_workflow, operation_name)
      @master_workflow = master_workflow
      @name = operation_name
      @edit_errors = []
    end

    def edit(new_name)
      @new_name = ::Decider::NameBasedConstantable.name_as_namespace(new_name.to_s)
      @is_name_changed = true unless @new_name == @name
      @valid_edit_called = false
    end

    def exists?
      @master_workflow.operation_names.include?(@name)
    end

    def valid_edit?
      validate_name_for_edit if @is_name_changed
      @edit_errors.empty?
      @valid_edit_called = true
    end

    def update
      raise 'Please check valid edit first' unless @valid_edit_called
      OperationConfiguration.update_operation(@master_workflow.name, @name, @new_name)
    end

    def edit_error_message
      @edit_errors.join(', ')
    end

    private

    def validate_name_for_edit
      @edit_errors << 'New name is not valid' unless @new_name.present?
      @edit_errors << 'New name already exists' if @master_workflow.operation_names.include?(@new_name)
    end
  end
end
