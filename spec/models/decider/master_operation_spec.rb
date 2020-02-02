module Nayati
  RSpec.describe MasterOperation do

    describe '#exists?' do
      let(:master_workflow_name) { 'abcd_pqrs' }
      let(:master_workflow) { MasterWorkflow.new(master_workflow_name) }
      let(:operation_name) { 'operation_of_abcd_pqrs' }
      context 'When operation is already present' do

        subject { MasterOperation.new(master_workflow, operation_name).exists? }
        it 'Returns true' do
          allow(master_workflow).to receive(:operation_names) { [operation_name, 'some_other_operation_name'] }
          expect(subject).to be_truthy
        end
      end

      context 'When operation does not exist' do
        subject { MasterOperation.new(master_workflow, operation_name).exists? }
        it 'Returns false' do
          allow(master_workflow).to receive(:operation_names) { ['some_other_operation_name'] }
          expect(subject).to be_falsey
        end
      end
    end
  end
end