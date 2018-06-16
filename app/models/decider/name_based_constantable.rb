module Decider
  module NameBasedConstantable
    def camelcased_name
      return "" if name.nil?
      name.split(' ').join('_').camelcase
    end
  end
end