module Nayati
  class MicroserviceOrientedWorkflowRunner
    def initialize(workflow, context_json, result_json)
      @workflow = workflow
      @context_json = context_json
      @result_json = result_json
    end

    def run
      operation_to_perform
    end
  end
end
