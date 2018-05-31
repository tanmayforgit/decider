require 'pry'
module Decider
  RSpec.describe Workflow, type: :model do
    describe '#result_obj' do
      let(:workflow) { create(:decider_workflow) }
      context 'Workflow specific result object is present' do
        it 'Returns that specific result object' do
          workflow
        end
      end

      context 'Workflow specific result object is not present' do
        it 'Returns default result object' do
        end
      end
    end
  end
end
