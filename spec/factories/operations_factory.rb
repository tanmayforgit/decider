FactoryGirl.define do
  factory :decider_operation, class: Decider::Operation do
    association :workflow, :factory => :decider_workflow
    name 'some_operation'
  end
end
