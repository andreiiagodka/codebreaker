# frozen_string_literal: true

class Game
  attr_reader :difficulty, :total_attempts, :used_attempts, :total_hints, :used_hints, :secret_code

  SECRET_CODE_LENGTH = 4
  ELEMENT_VALUE_RANGE = (1..6).freeze

  DELIMITER = ''
  EXACT_MATCH = '+'
  NUMBER_MATCH = '-'

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

  def hints_available?
    @used_hints >= @total_hints
  end

  def win?(guess_code)
    convert_to_digit_array(guess_code) == @secret_code
  end

  def loss?
    @used_attempts == @total_attempts
  end

  def increment_used_attempts
    @used_attempts += 1
  end

  def mark_guess(guess_code)
    @converted_input = convert_to_digit_array(guess_code)
    cloned_code = @secret_code.clone
    marked_guess = []
    exact_match(cloned_code, marked_guess)
    number_match(cloned_code, marked_guess)
    convert_to_string(marked_guess)
  end

  private

  def generate
    Array.new(SECRET_CODE_LENGTH) { rand(ELEMENT_VALUE_RANGE) }
  end

  def increment_used_hints
    @used_hints += 1
  end

  def convert_to_digit_array(guess_code)
    guess_code.split(DELIMITER).map(&:to_i)
  end

  def exact_match(cloned_code, marked_guess)
    @converted_input.each_with_index do |digit, index|
      next unless digit == @secret_code[index]

      marked_guess << EXACT_MATCH
      remove_digit(digit, cloned_code)
    end
  end

  def number_match(cloned_code, marked_guess)
    cloned_code.each do |digit|
      next unless @converted_input.include? digit

      marked_guess << NUMBER_MATCH
    end
  end

  def remove_digit(digit, cloned_code)
    cloned_code.delete_at(cloned_code.index(digit))
  end

  def convert_to_string(guess)
    guess.join.to_s
  end
end
