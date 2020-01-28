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
    validates :identifier, uniqueness: true
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
                      ::Decider::WorkflowResults::Base
                    end
      result_class.new
    end

    class << self
      def name_selection_options
        Decider::OperationConfiguration.workflow_names.map { |name| [name, name] }
      end

      # Workflow json has following structure
      # {
      #   name: 'workflow_name'
      #   initial_operation_name: 'operation_name',
      #   end_operation_name: 'end_operation_name'
      #   workflow_identifier: 'workflow_identifier',
      #   operations: [
      #     { name: 'operation_name', after_failure_operation_name: 'afo_name', after_success_operation_name: 'aso_name' },
      #     .
      #     .
      #     .

      #   ]
      # }

      def create_or_update_from_workflow_json(workflow_hash)
        ActiveRecord::Base.transaction do
          workflow_name = workflow_hash[:name]
          workflow_identifier = workflow_hash[:workflow_identifier]

          workflow_constant = workflow_identifier.constantize

          wf = find_or_initialize_by(name: workflow_constant.to_s, identifier: workflow_identifier)
          wf.save!

          initial_operation_name = workflow_hash[:initial_operation_name]

          initial_operation_record = wf.operations.find_or_initialize_by(name: initial_operation_name)
          initial_operation_record.save!

          workflow_hash[:operations].each do |operation_hash|
            operation_name = operation_hash[:name].to_s
            operation_record = wf.operations.find_or_initialize_by(name: operation_name)

            after_failure_operation_name = operation_hash[:after_failure_operation_name].to_s
            if after_failure_operation_name.present?
              after_failure_operation_record = wf.operations.find_or_initialize_by(name: after_failure_operation_name)
              after_failure_operation_record.save!
              operation_record.after_failure_operation = after_failure_operation_record
            end

            after_success_operation_name = operation_hash[:after_success_operation_name].to_s
            if after_success_operation_name.present?
              after_success_operation_record = wf.operations.find_or_initialize_by(name: after_success_operation_name)
              after_success_operation_record.save!
              operation_record.after_success_operation = after_success_operation_record
            end

            operation_record.save!
          end
          # puts "---------------- printing operation sequences ----------------"
          # wf.print_sequences
          # puts "-----------------------------------------------------------------"
        end
      end
    end

    private

    def configuration
      @configuration ||= OperationConfiguration.new
    end

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

    def assign_from_creation_params(params)

    end


    # class Master
    #   attr_reader :name, :name_as_namespace, :operations
    #   def initialize(workflow_name)
    #     @name = @workflow_name
    #     @operations = operations_from_configuration(workflow_name)
    #     @name_as_namespace = Decider::NameBasedConstantable.name_as_namespace(workflow_name)
    #   end

      class << self
        def assign_from_creation_params(params)
          wf = self.new(name: params[:name])
          wf.initial_operation_name = params[:initial_operation_name]
          wf
        end
      end

    #   private

    #   def operations_from_configuration(workflow_name)
    #     configuration[@name_as_namespace]
    #   end

    #   def configuration
    #     @configuration ||= ( YAML.load(File.open("#{Rails.root}/config/operations.yml")) || {} )
    #   end
    # end

    class ContextNotSetError < StandardError
    end

  end
end
