# frozen_string_literal: true

class Game
  attr_reader :difficulty, :total_attempts, :used_attempts, :total_hints, :used_hints, :secret_code

  def initialize(difficulty)
    @difficulty = difficulty[:level]
    @total_attempts = difficulty[:attempts]
    @used_attempts = 0
    @total_hints = difficulty[:hints]
    @used_hints = 0
    @secret_code = generate
    @shuffled_code = @secret_code.shuffle
  end

  def hints_limit?
    Validator.check_hints_quantity(self)
  end

  def use_hint
    increment_used_hints
    @shuffled_code.shift
  end

  def increment_used_attempts
    @used_attempts += 1
  end

  def win?(marked_guess)
    Validator.check_win_combination(marked_guess)
  end

  def loss?
    Validator.check_attempts_quantity(self)
  end

  private

  def generate
    Array.new(4) { rand(ELEMENT_MIN_VALUE..ELEMENT_MAX_VALUE) }
  end

  def increment_used_hints
    @used_hints += 1
  end
end
