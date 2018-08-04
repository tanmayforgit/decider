module Decider
  class MasterOperationsController < ApplicationController
    helper_method :master_operation, :master_workflow

    def show
      @master_workflow = MasterWorkflow.new(params[:name])
    end

    def edit
    end

    def update
      master_operation.edit(params[:updated_operation_name], params[:end_point])
      if master_operation.valid_edit?
        master_operation.update
        flash[:message] = "Updated Succesfully"
      else
        flash[:errors] = master_operation.edit_error_message
      end

      redirect_to master_operations_edit_path(workflow_name: master_workflow.name, operation_name: master_operation.name)
    end

    def add_operation
      @master_workflow = MasterWorkflow.new(params[:workflow_name])
      @master_workflow.add_operation(params[:operation_name])
    end

    def create
      wf = Decider::MasterWorkflow.new(params[:workflow_name])
      operation_name = params[:operation_name]
      if wf.valid_to_add_operation?(operation_name)
        wf.add_operation(operation_name)
        flash[:message] = 'Succesfully added new operation'
      else
        flash[:message] = wf.operation_addition_error_message
      end

      redirect_to master_workflows_show_path(name: wf.name)
    end

    def master_workflow
      @master_workflow ||= MasterWorkflow.new(params[:workflow_name])
    end

    def master_operation
      @master_operation ||= MasterOperation.new(master_workflow, params[:operation_name])
    end

    private

    def permitted_workflow_creation_params
      params.permit(:name)
    end
  end
end
