module Decider
  class Operation < ApplicationRecord
    belongs_to :workflow

    validates :name, presence: true
  end
end
