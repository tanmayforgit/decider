module Decider
  class Operation < ApplicationRecord
    include NameBasedConstantable

    belongs_to :workflow
    belongs_to :after_success_operation, class_name: "Operation", foreign_key: :after_success_operation_id, required: false
    belongs_to :after_failure_operation, class_name: "Operation", foreign_key: :after_failure_operation_id, required: false
    before_save :format_name


    validates :name, presence: true

    def operation_implementer_klass_name
      "#{workflow.camelcased_name}Workflow::#{name.camelcase}"
    end

    def build_implementer(operation_context)
      operation_implementer_klass_name.constantize.new(operation_context)
    end

    def format_name
      self.name = namespaced_name
    end
  end
end
