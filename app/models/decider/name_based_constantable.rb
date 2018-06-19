module Decider
  module NameBasedConstantable
    def camelcased_name
      return "" if name.nil?
      Decider::NameBasedConstantable.name_as_constant(self.name)
    end

    def self.name_as_constant(name)
      name.split(' ').join('_').camelcase
    end

    def self.name_as_namespace(name)
      name.downcase.split(' ').join('_')
    end
  end
end
