module Decider
  class OperationImplementerBase
    attr_accessor :operation_context
    def initialize(operation_context)
      @operation_context = operation_context
    end

    def to_fail?
      false
    end

    def to_abandon?
      false
    end

    def perform_failure

    end

    def perform_abandonment

    end
  end
end
