# frozen_string_literal: true

class Guess < ValidatedEntity
  attr_reader :guess_code, :errors

  def initialize(guess_code)
    super()
    @guess_code = guess_code
  end

  def validate
    return if hint?

    @errors << fault.secret_code_format unless Validator.check_integer(@guess_code)
    @errors << fault.secret_code_length unless Validator.check_secret_code_length(@guess_code)
    @errors << fault.secret_code_digits_range unless Validator.check_secret_code_digits_range(@guess_code)
  end

  def hint?
    Validator.check_hint(@guess_code)
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

  private

  def convert_input(guess_code)
    guess_code.split('').map(&:to_i)
  end

  def exact_match(input_digits, cloned_code, marked_guess)
    input_digits.each_with_index do |digit, index|
      next unless digit == @secret_code[index]

      marked_guess << '+'
      remove_digit(digit, cloned_code)
    end
  end

  def number_match(input_digits, cloned_code, marked_guess)
    cloned_code.each do |digit|
      next unless input_digits.include? digit

      marked_guess << '-'
    end
  end

  def convert_guess(guess)
    guess.join('')
  end

  def remove_digit(digit, cloned_code)
    cloned_code.delete_at(cloned_code.index(digit))
  end
end
