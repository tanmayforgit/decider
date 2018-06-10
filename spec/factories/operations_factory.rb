FactoryGirl.define do
  factory :decider_operation, class: Decider::Workflow do
    name 'Doing something'
  end
end
