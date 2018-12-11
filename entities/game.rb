# frozen_string_literal: true

class Game
  attr_reader :difficulty, :total_attempts, :used_attempts, :total_hints, :used_hints, :secret_code, :errors

  def initialize(difficulty)
    @difficulty = difficulty[:difficulty]
    @total_attempts = difficulty[:attempts]
    @used_attempts = 0
    @total_hints = difficulty[:hints]
    @used_hints = 0
    @secret_code = generate
    @errors = []
    @shuffled_code = @secret_code.shuffle
  end

  def is_valid_secret_code?(input_code, errors = @errors)
    return if Validator.check_hint(input_code)
    errors << fault.get(:secret_code_format) unless Validator.check_integer(input_code)
    errors << fault.get(:secret_code_length) unless Validator.check_secret_code_length(input_code)
    errors << fault.get(:secret_code_digits_range) unless Validator.check_secret_code_digits_range(input_code)
  end

  def hint
    increment_used_hints
    @shuffled_code.shift
  end

  private

  def generate
    Array.new(4) { rand(ELEMENT_MIN_VALUE..ELEMENT_MAX_VALUE) }
  end

  def increment_used_attempts
    @used_attempts += 1
  end

  def increment_used_hints
    @used_hints += 1
  end

  def clear_errors
    @errors = []
  end

  def fault
    @fault ||= Fault.new
  end
end
