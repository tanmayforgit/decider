module Decider
  class Workflow < ApplicationRecord
    attr_accessor :context

    def name_space
      name.parameterize.underscore
    end

    def klass_name
      name_space.camelcase + 'Workflow'
    end

    def klass
      raise ContextNotSetError.new unless context.present?
      klass_name.constantize.new(context)
    end

    def specific_result_obj_klass_constant_name
      "Decider::WorkflowResults::#{klass_name}"
    end

    def result_obj_klass
      result_class = begin
                      Module.const_get(specific_result_obj_klass_constant_name)
                    rescue NameError
                      WorkflowResults::Default
                    end
      result_class.new(self)
    end

    private

    class ContextNotSetError < StandardError
    end
  end
end
