# Each operation service is allowed to accept context_json, result_json, modify it and send it back again
#


module Decider
  RSpec.describe MicroserviceOrientedWorkflowRunner do
    describe '#run' do
      let(:context_json) { {} }
      let(:result_json) { {} }
      let(:workflow) { create(:decider_workflow) }
      subject { Decider::MicroserviceOrientedWorkflowRunner.new(workflow, context_json, result_json).run }

      it 'Runs the workflow as per services' do
      end

    end
  end
end