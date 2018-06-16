module Decider
  RSpec.describe Operation do
    describe '#operation_implementer_klass_name' do
      let(:operation) { create(:decider_operation)}
      subject { operation.operation_implementer_klass_name }

      it 'Returns workflow namespaced klass name' do
        expect(subject).to eq('DoingSomething::SomeOperation')
      end
    end

    describe '#build_implementer' do
      let(:operation) { create(:decider_operation)}
      let(:context) { {} }
      let(:implementer_klass) { double }
      let(:implementer_klass_name) { double }
      let(:implementer_instance) { double }

      subject { operation.build_implementer(context) }
      it 'Returns implementer class' do
        allow(operation).to receive(:operation_implementer_klass_name) { implementer_klass_name }
        allow(implementer_klass_name).to receive(:constantize) { implementer_klass }
        allow(implementer_klass).to receive(:new).with(context) { implementer_instance }
        expect(subject).to eq(implementer_instance)
        # allow()
      end
    end

    describe 'associations' do
      it { Operation.reflect_on_association(:after_success_operation).macro.should  eq(:belongs_to) }
      it { Operation.reflect_on_association(:after_failure_operation).macro.should  eq(:belongs_to) }
      it { Operation.reflect_on_association(:workflow).macro.should  eq(:belongs_to) }
    end

    describe '#validatoin' do
      let(:workflow) { create(:decider_workflow) }
      let(:operation) { Decider::Operation.new }
      subject { operation.valid? }

      it 'Returns false with proper error message' do
        expect(subject).to be_falsey
        expect(operation.errors.messages[:workflow]).to include('must exist')
        expect(operation.errors.messages[:name]).to include("can't be blank")
      end
    end
  end
end
