FactoryGirl.define do
  factory :nayati_operation, class: Nayati::Operation do
    association :workflow, :factory => :nayati_workflow
    name 'some_operation'
  end
end
