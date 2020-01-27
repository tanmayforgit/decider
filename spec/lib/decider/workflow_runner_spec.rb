require_relative '../../../lib/decider/workflow_runner'
require_relative '../../../lib/decider/workflow_results/base'
module Decider
  RSpec.describe WorkflowRunner do
            #                initial_operation
            #                   /        \
            #                 (succ)     (fail)
            #                /              \
            #             op1                op2
            #             /\                  /\
            #            /  \                /  \
            #         (s).  (f)             (s). (f)
            #         /       \            /      \
            #     op3        op4         op5       op6

    describe '#run' do
      let(:result_obj) { double }
      let(:context) { double }
      let(:abandoning_operation_implementer) { double(to_abandon?: true, perform_abandonment: true) }
      let(:failing_operation_implementer) { double(to_fail?: true, to_abandon?: false, perform_failure: true) }
      let(:succeeding_operation_implementer) { double(to_fail?: false, to_abandon?: false, perform: true) }
      let(:workflow) { double(initial_operation: initial_operation, result_obj: result_obj) }
      let(:initial_operation) { double(after_success_operation: op1, after_failure_operation: op2, present?: true, name: 'initial_operation') }
      let(:op1) { double(after_success_operation: op3, after_failure_operation: op4, name: 'op1') }
      let(:op2) { double(after_success_operation: op5, after_failure_operation: op6, name: 'op2') }
      let(:op3) { double(after_success_operation: nil, after_failure_operation: nil, name: 'op3') }
      let(:op4) { double(after_success_operation: nil, after_failure_operation: nil, name: 'op4') }
      let(:op5) { double(after_success_operation: nil, after_failure_operation: nil, name: 'op5') }
      let(:op6) { double(after_success_operation: nil, after_failure_operation: nil, name: 'op6') }
      subject { WorkflowRunner.new(workflow, context).run }

      context 'One of the operation abandons' do
        it 'Runs the operations as per success and failure until one of the operation abandons and runs perform abandonment method on abandoning operation' do
          allow(initial_operation).to receive(:build_implementer).with(context) { succeeding_operation_implementer }
          allow(op1).to receive(:build_implementer).with(context) { abandoning_operation_implementer }
          expect(succeeding_operation_implementer).to receive(:perform)
          expect(op1).not_to receive(:perform)
          expect(op3).not_to receive(:build_implementer)
          expect(op4).not_to receive(:build_implementer)
          expect(abandoning_operation_implementer).to receive(:perform_abandonment)

          subject
        end
      end

      context 'None of the operation abandons' do
        it 'Runs operations as per after failure and after success operations' do
          allow(initial_operation).to receive(:build_implementer).with(context) { failing_operation_implementer }
          expect(op2).to receive(:build_implementer).with(context) { succeeding_operation_implementer }
          expect(op5).to receive(:build_implementer).with(context) { succeeding_operation_implementer }

          expect(failing_operation_implementer).to receive(:perform_failure).exactly(1).times
          expect(succeeding_operation_implementer).to receive(:perform).exactly(2).times
          subject
        end
      end
    end
  end
end
