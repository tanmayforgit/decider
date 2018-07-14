module Decider
  class WorkflowsController < ApplicationController
    def new

    end

    def all_operations
      respond_to do |format|
        format.json { render json: OperationConfiguration.new.operations(params[:workflow_name])}
      end
    end

    def add_operations

    end

    def create
      wf = Decider::Workflow.new
      wf.assign_from_creation_params(permitted_workflow_creation_params)
    end

    private

    def permitted_workflow_creation_params
      params.permit(:name, :initial_operation_name)
    end
  end
end
