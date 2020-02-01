module Decider
  class OperationImplementerBase
    attr_accessor :operation_context
    def initialize(operation_context)
      @operation_context = operation_context
    end

    def to_fail?
      puts "#{__callee__} called on #{self.class.name}"
      false
    end

    def perform_failure
      puts "#{__callee__} called on #{self.class.name}"
    end

    def perform
      puts "#{__callee__} called on #{self.class.name}"
    end
  end
end
