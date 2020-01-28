module Decider
  class WorkflowRunner
    def initialize(workflow, context)
      @workflow = workflow
      @context = context
      @result_obj = workflow.result_obj
    end

    def run
      operation_to_perform = @workflow.initial_operation
      operations_performed = []

      while !operation_to_perform.nil? && !operations_performed.include?(operation_to_perform.name) # && safety_count > 0
        operation_klass_instance = operation_to_perform.build_implementer(@context, @result_obj)
        if operation_klass_instance.to_abandon?
          operation_klass_instance.perform_abandonment
          break
        end

        operations_performed << operation_to_perform.name

        if operation_klass_instance.to_fail?
          operation_klass_instance.perform_failure
          operation_to_perform = operation_to_perform.after_failure_operation
        else
          operation_klass_instance.perform
          operation_to_perform = operation_to_perform.after_success_operation
        end
      end

      @result_obj
    end
  end
end