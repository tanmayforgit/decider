module Decider
  RSpec.describe MasterWorkflow do

    describe '#exists?' do
      let(:workflow_name) { 'abcd_pqrs' }
      let(:master_workflow) { MasterWorkflow.new(workflow_name) }
      context 'Operation configuration#workflow_names does not have workflow name' do

        subject { master_workflow.exists? }
        it 'Returns false' do
          allow(Decider::OperationConfiguration).to receive(:workflow_names) { [] }
          expect(subject).to be_falsey
        end
      end
    end
  end
end