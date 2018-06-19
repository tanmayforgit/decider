module Decider
  class OperationImplementerBase
    attr_accessor :operation_context
    def initialize(operation_context)
      @operation_context = operation_context
    end
  end
end