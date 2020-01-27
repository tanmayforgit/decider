class LoosingWaitDeciderService
  def initialize()
  end

  def call
    Decider::WorkflowRunner.new(workflow, context).run
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