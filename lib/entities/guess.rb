# frozen_string_literal: true

class Guess < ValidatedEntity
  attr_reader :guess_code, :errors

  SECRET_CODE_LENGTH = 4
  ELEMENT_MIN_VALUE = 1
  ELEMENT_MAX_VALUE = 6

  HINT = 'hint'
  PLUS = '+'
  MINUS = '-'

  def initialize(guess_code)
    super()
    @guess_code = guess_code
  end

  def validate
    return if hint?

    @errors << fault.secret_code_format unless check_integer
    @errors << fault.secret_code_length(SECRET_CODE_LENGTH) unless check_length
    @errors << fault.secret_code_digits_range(ELEMENT_MIN_VALUE, ELEMENT_MAX_VALUE) unless check_digits_range
  end

  def mark_guess(secret_code)
    @secret_code = secret_code
    cloned_code = @secret_code.clone
    input_digits = convert_input(@guess_code)
    marked_guess = []
    exact_match(input_digits, cloned_code, marked_guess)
    number_match(input_digits, cloned_code, marked_guess)
    convert_guess(marked_guess)
  end

  def hint?
    @guess_code == HINT
  end

  private

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

  def check_integer
    @guess_code.to_i.to_s == @guess_code
  end

  def check_length
    @guess_code.length == SECRET_CODE_LENGTH
  end

  def check_digits_range
    @guess_code.each_char { |digit| break unless digit.to_i.between?(ELEMENT_MIN_VALUE, ELEMENT_MAX_VALUE) }
  end
end
