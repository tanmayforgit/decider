module ComingToOfficeWorkflow
  class CatchingRickshaw < Decider::OperationImplementerBase
    def initialize(operation_context, result)
      @operation_context = operation_context
      @result = result
    end

    def to_fail?
      # Please implement or delete
    end

    def to_abandon?
      # Please implement or delete
    end

    def perform_failure
      # Please implement or delete
    end

    def perform_abandonment
      # Please implement or delete
    end

    def perform
      # Please implement
    end
  end
end
