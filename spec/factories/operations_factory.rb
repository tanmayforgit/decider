FactoryGirl.define do
  factory :nayati_operation, class: Decider::Operation do
    association :workflow, :factory => :nayati_workflow
    name 'some_operation'
  end
end
