module Decider
  class MasterOperationsController < ApplicationController
    def show
      @master_workflow = MasterWorkflow.new(params[:name])
    end

    def add_operation
      @master_workflow = MasterWorkflow.new(params[:workflow_name])
      @master_workflow.add_operation(params[:operation_name])
  end

    def create
      wf = Decider::MasterWorkflow.new(params[:name])
      if wf.valid?
        wf.save!
        flash[:message] = 'Succesfully created new workflow'
      else
        flash[:message] = "#{wf.error_message}"
      end

      redirect_to master_workflows_index_path
    end

    private

    def permitted_workflow_creation_params
      params.permit(:name)
    end
  end
end
