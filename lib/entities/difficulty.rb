# frozen_string_literal: true

class Difficulty < ValidatedEntity
  attr_reader :level, :errors

  def initialize(difficulty)
    super()
    @difficulty = difficulty.to_sym
    @level = DIFFICULTIES[@difficulty]
  end

  def validate
    @errors << fault.unexpected_difficulty unless Validator.check_difficulty(@difficulty)
  end
end
