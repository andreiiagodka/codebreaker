# frozen_string_literal: true

class Difficulty < ValidatedEntity
  attr_reader :level, :errors

  DIFFICULTIES = {
    easy: {
      level: 'easy',
      attempts: 15,
      hints: 3
    },

    medium: {
      level: 'medium',
      attempts: 10,
      hints: 1
    },

    hard: {
      level: 'hard',
      attempts: 5,
      hints: 1
    }
  }.freeze

  def initialize(difficulty)
    super()
    @difficulty = difficulty.to_sym
    @level = DIFFICULTIES[@difficulty]
  end

  def validate
    @errors << fault.unexpected_difficulty unless check_difficulty
  end

  def self.list
    DIFFICULTIES.keys.map(&:to_s).map(&:capitalize)
  end

  private

  def check_difficulty
    DIFFICULTIES.key?(@difficulty)
  end
end
