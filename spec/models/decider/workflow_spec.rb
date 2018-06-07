require 'pry'
module Decider
  RSpec.describe Workflow, type: :model do
    describe '#name_space' do
      let(:workflow) { create(:decider_workflow)}

      subject { workflow.name_space }
      it 'Returens proper name space' do
        expect(subject).to eq('doing_something')
      end
    end

    describe '#klass_name' do
      let(:workflow) { create(:decider_workflow)}

      subject { workflow.klass_name }
      it 'Returns proper name space' do
        expect(subject).to eq('DoingSomethingWorkflow')
      end
    end

    describe '#klass' do
      let(:workflow) { create(:decider_workflow)}

      subject { workflow.klass }

      context 'Workflow running context is not set' do
        it 'Raises an error' do
          expect{subject}.to raise_error(Decider::Workflow::ContextNotSetError)
        end
      end

      let(:implementer_klass_name) { "DoingSomething" }
      let(:implementer_klass) { double }
      let(:implementer_klass_instance) { double }
      let(:workflow_running_context) { double }
      it 'Returns the implementer class instance of the workflow' do
        workflow.context = workflow_running_context
        allow(workflow).to receive(:klass_name) { implementer_klass_name }
        expect(implementer_klass_name).to receive(:constantize) { implementer_klass }
        expect(implementer_klass).to receive(:new).with(workflow_running_context) {implementer_klass_instance}
        expect(subject).to eq(implementer_klass_instance)
      end
    end

    describe '#specific_result_obj_klass_constant_name' do
      let(:workflow) { create(:decider_workflow) }
      subject { workflow.specific_result_obj_klass_constant_name }

      it 'Returns specific result object class name' do
        expect(subject).to eq("Decider::WorkflowResults::DoingSomethingWorkflow")
      end
    end

    describe '#result_obj_klass' do
      context 'Specific result class is present' do
        let(:workflow) { create(:decider_workflow) }
        let(:result_klass) { double }
        let(:result_klass_instance) { double }
        subject { workflow.result_obj_klass }
        it 'Returns that class' do
          allow(Module).to receive(:const_get).with(workflow.specific_result_obj_klass_constant_name) { result_klass }
          allow(result_klass).to receive(:new).with(workflow) { result_klass_instance }
          expect(subject).to eq(result_klass_instance)
        end
      end

      context 'Specific result class is absent' do
        let(:workflow) { create(:decider_workflow) }
        subject { workflow.result_obj_klass }
        it 'Returns that class' do
          expect(subject).to be_an_instance_of(Decider::WorkflowResults::Default)
          expect(subject.workflow).to eq(workflow)
        end
      end
    end

    describe '#specific_result_klass_present?' do
      let(:workflow) { create(:decider_workflow)}
      subject { workflow.specific_result_klass_present? }

      it 'Returns false if specific_result_klass is present?' do

      end
    end

    describe '#result_obj' do
      let(:workflow) { create(:decider_workflow) }
      context 'Workflow specific result object is present' do
        it 'Returns that specific result object' do
          # allow(Object).to receive(:const_defined?).with("Result"workflow.name)
        end
      end

      context 'Workflow specific result object is not present' do
        it 'Returns default result object' do
        end
      end
    end
  end
end
