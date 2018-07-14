FactoryGirl.define do
  factory :decider_workflow, class: Decider::Workflow do
    name 'Doing something'
    initial_operation_name 'Initial Operation'
    identifier 'some identifier'
  end
end
