# frozen_string_literal: true

class Game
  attr_reader :difficulty, :total_attempts, :used_attempts, :total_hints, :used_hints, :secret_code

  SECRET_CODE_LENGTH = 4
  ELEMENT_VALUE_RANGE = (1..6).freeze

  PLUS = '+'
  MINUS = '-'

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
    convert_input(guess_code) == @secret_code
  end

  def loss?
    @used_attempts == @total_attempts
  end

  def increment_used_attempts
    @used_attempts += 1
  end

  def mark_guess(guess_code)
    @secret_code = secret_code
    cloned_code = @secret_code.clone
    input_digits = convert_input(guess_code)
    marked_guess = []
    exact_match(input_digits, cloned_code, marked_guess)
    number_match(input_digits, cloned_code, marked_guess)
    convert_guess(marked_guess)
  end

  private

  def generate
    Array.new(SECRET_CODE_LENGTH) { rand(ELEMENT_VALUE_RANGE) }
  end

  def increment_used_hints
    @used_hints += 1
  end

  def convert_input(guess_code)
    guess_code.split('').map(&:to_i)
  end

  def exact_match(input_digits, cloned_code, marked_guess)
    input_digits.each_with_index do |digit, index|
      next unless digit == @secret_code[index]

      marked_guess << PLUS
      remove_digit(digit, cloned_code)
    end
  end

  def number_match(input_digits, cloned_code, marked_guess)
    cloned_code.each do |digit|
      next unless input_digits.include? digit

      marked_guess << MINUS
    end
  end

  def convert_guess(guess)
    guess.join('')
  end

  def remove_digit(digit, cloned_code)
    cloned_code.delete_at(cloned_code.index(digit))
  end
end
