require_relative '../../../lib/decider/workflow_runner'
require_relative '../../../lib/decider/workflow_results/base'
module Decider
  RSpec.describe WorkflowRunner do
    describe '#new' do
      context 'When result object is present for the workflow' do
        let(:result_obj) { double }
        let(:workflow) { double(result_obj:  result_obj) }
        let(:operation_context) { double }
        subject { Decider::WorkflowRunner.new(workflow, operation_context) }
        it 'Initialized with corresponding result object' do
          expect(subject.instance_variable_get(:@result_obj)).to eq(result_obj)
          expect(subject.instance_variable_get(:@workflow)).to eq(workflow)
          expect(subject.instance_variable_get(:@operation_context)).to eq(operation_context)
        end
      end

      context 'When result object is absent for the workflow' do
        let(:workflow) { double(result_obj:  nil) }
        let(:operation_context) { double }
        let(:default_result_obj) { double(WorkflowResults::Base) }
        subject { Decider::WorkflowRunner.new(workflow, operation_context) }
        it 'Initialized with default result object' do
          allow(WorkflowResults::Base).to receive(:new) { default_result_obj }
          expect(subject.instance_variable_get(:@result_obj)).to eq(default_result_obj)
          expect(subject.instance_variable_get(:@workflow)).to eq(workflow)
          expect(subject.instance_variable_get(:@operation_context)).to eq(operation_context)
        end
      end
    end
  end
end
