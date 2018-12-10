# frozen_string_literal: true
require 'pry'
class SecretCode
  attr_reader :secret_code, :errors

  def initialize
    @secret_code = generate
    @errors = []
    @cloned_code = @secret_code.shuffle
  end

  def validate(secret_code)
    clear_errors
    @errors << error_phrase.secret_code_format unless Validator.check_integer(secret_code)
    @errors << error_phrase.secret_code_length unless Validator.check_secret_code_length(secret_code)
    @errors << error_phrase.secret_code_digits_range unless Validator.check_secret_code_digits_range(secret_code)
  end

  def hint
    @cloned_code.shift
  end

  def mark_guess(input_code, secret_code = @secret_code)
    marked_guess = find_matches(input_code, secret_code)
    convert_guess(marked_guess)
  end

  private

  def generate
    Array.new(4) { rand(ELEMENT_MIN_VALUE..ELEMENT_MAX_VALUE) }
  end

  def clear_errors
    @errors = []
  end

  def error_phrase
    @error_phrase ||= Error.new
  end

  def find_matches(input, generated)
    cloned = generated.clone
    digits = convert_input(input)
    marked_guess = []
    exact_match(digits, marked_guess, cloned)
    number_match(digits, marked_guess, cloned)
    marked_guess
  end

  def exact_match(digits, marked_guess, cloned)
    secret_code = cloned.clone
    digits.each_with_index do |digit, index|
      next unless digit == secret_code[index]

      marked_guess << '+'
      remove_digit(digit, cloned)
    end
  end

  def number_match(digits, marked_guess, cloned)
    digits.each do |digit|
      next unless cloned.include? digit

      digit_quantity = cloned.count(digit)
      digit_quantity.times { marked_guess << '-' }
    end
  end

  def remove_digit(digit, cloned)
    cloned.delete_at(cloned.index(digit))
  end

  def convert_input(secret_code)
    secret_code.split('').map(&:to_i)
  end

  def convert_guess(guess)
    guess.join('')
  end
end
