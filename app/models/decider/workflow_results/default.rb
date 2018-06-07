module Decider
  module WorkflowResults
    class Default
      attr_reader :workflow
      def initialize(workflow)
        @workflow = workflow
      end
    end
  end
end