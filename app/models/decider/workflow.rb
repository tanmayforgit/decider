require 'pry'
module Decider
  class Workflow < ApplicationRecord
    include NameBasedConstantable

    attr_accessor :context, :initial_operation_name
    has_many :operations
    after_initialize :set_initial_creation_flag
    belongs_to :initial_operation, class_name: 'Operation', optional: true
    after_create :create_initial_operation

    validates :name, presence: true
    validates :initial_operation, presence: true, unless: :initial_creation_flag_set?
    validates :initial_operation_name, presence: { message: 'Please set initial_operation_name'}, if: :initial_creation_flag_set?

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

    def set_initial_creation_flag
      @creation_flag = true
    end

    def initial_creation_flag_set?
      @creation_flag
    end

    def create_initial_operation
      op = self.operations.new(name: initial_operation_name)
      op.save
      self.initial_operation = op
      self.save

    end

    class ContextNotSetError < StandardError
    end
  end
end
