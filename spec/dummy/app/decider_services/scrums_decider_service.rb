require 'nayati/workflow_runner'
class ScrumsNayatiService

  def initialize()
  end

  def call
    Nayati::WorkflowRunner.new(workflow, context).run
  end

  private
    def context
      {

      }
    end

    def workflow
      # Find workflow which is supposed to be run
    end
end