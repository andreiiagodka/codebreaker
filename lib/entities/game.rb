# frozen_string_literal: true

class Game
  attr_reader :difficulty, :total_attempts, :used_attempts, :total_hints, :used_hints, :secret_code

  SECRET_CODE_LENGTH = 4
  ELEMENT_VALUE_RANGE = (1..6).freeze

  WIN_COMBINATION = '++++'

  def initialize(difficulty)
    @difficulty = difficulty[:level]
    @total_attempts = difficulty[:attempts]
    @used_attempts = 0
    @total_hints = difficulty[:hints]
    @used_hints = 0
    @secret_code = generate
    @shuffled_code = @secret_code.shuffle
  end

  def use_hint
    increment_used_hints
    @shuffled_code.shift
  end

  def hints_limit?
    @used_hints >= @total_hints
  end

  def win?(marked_guess)
    marked_guess == WIN_COMBINATION
  end

  def loss?
    @used_attempts == @total_attempts
  end

  def increment_used_attempts
    @used_attempts += 1
  end

  private

  def generate
    Array.new(SECRET_CODE_LENGTH) { rand(ELEMENT_VALUE_RANGE) }
  end

  def increment_used_hints
    @used_hints += 1
  end
end
