module Decider
  class WorkflowRunner
    def initialize(workflow, operation_context)
      @workflow = workflow
      @operation_context = operation_context
      @result_obj = if !workflow.result_obj.nil?
                      workflow.result_obj
                    else
                      default_result_object
                    end
    end

    # def run
    #   ActiveRecord::Base.transaction do
    #     operation_to_perform = @workflow.initial_operation
    #     operations_performed = []
    #     @operation_context
    #     safety_count = 20 # Max number of operations that can be performed

    #     while operation_to_perform.present? && !operations_performed.include?(operation_to_perform.name) && safety_count > 0
    #       safety_count -= 1
    #       operation_klass_instance = ServiceOrientedOperationImplementerBuilder.build(operation_to_perform, @operation_context, @service_result_object)

    #       if operation_klass_instance.to_abandon?
    #         raise FailTransaction.new
    #       end

    #       operations_performed << operation_to_perform.name

    #       if operation_klass_instance.to_fail?
    #         operation_klass_instance.perform_failure
    #         operation_to_perform = operation_to_perform.after_failure_operation
    #       else
    #         operation_klass_instance.perform
    #         operation_to_perform = operation_to_perform.after_success_operation
    #       end

    #       break if operation_to_perform.name == @workflow.end_operation.name
    #     end

    #   end
    #   # operation_sequence.each { |operation_implementer| operation_implementer.perform }
    #   @service_result_object
    # rescue FailTransaction => e
    #   @service_result_object
    # end

    private

    def default_result_object
      WorkflowResults::Base.new
    end

    # class FailTransaction < StandardError
    # end
  end
end