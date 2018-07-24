module Decider
  class MasterWorkflowsController < ApplicationController
    def index
      @workflow_names = Decider::MasterWorkflow.all_workflow_names
    end

    def all_operations
      respond_to do |format|
        format.json { render json: OperationConfiguration.new.operations(params[:workflow_name])}
      end
    end

    def show
      @master_workflow = MasterWorkflow.new(params[:name])
    end

    def add_operation
      workflow = MasterWorkflow.new(params[:workflow_name])
      workflow.add_operation(params[:operation_name])
      flash[:message] = "Operation added Succesfully"
      redirect_to master_workflows_show_path(name: workflow.name)
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
