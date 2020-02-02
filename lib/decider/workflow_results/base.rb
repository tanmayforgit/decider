module Nayati
  module WorkflowResults
    class Base
      def initialize
        @errors = {base: []}.with_indifferent_access
        @data = {}.with_indifferent_access
      end

      def success?
        !@errors.any?
      end

      def add_base_error(error_message)
        @errors[:base] << error_message
      end
    end
  end
end