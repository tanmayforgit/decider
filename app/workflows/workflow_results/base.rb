module WorkflowResults
  class Base
    def initialize
      @errors = {}.with_indifferent_access
    end
  end
end