# frozen_string_literal: true

class SecretCode
  attr_reader :secret_code, :errors

  def initialize
    @secret_code = generate
    @errors = []
    @shuffled_code = @secret_code.shuffle
  end
 
  def validate(secret_code)
    clear_errors
    @errors << fault.get(:secret_code_format) unless Validator.check_integer(secret_code)
    @errors << fault.get(:secret_code_length) unless Validator.check_secret_code_length(secret_code)
    @errors << fault.get(:secret_code_digits_range) unless Validator.check_secret_code_digits_range(secret_code)
  end

  def hint
    @shuffled_code.shift
  end

  def mark_guess(input_code, secret_code = @secret_code)
    cloned_code = secret_code.clone
    input_digits = convert_input(input_code)
    marked_guess = []
    exact_match(input_digits, cloned_code, marked_guess)
    number_match(input_digits, cloned_code, marked_guess)
    convert_guess(marked_guess)
  end

  private

  def generate
    Array.new(4) { rand(ELEMENT_MIN_VALUE..ELEMENT_MAX_VALUE) }
  end

  def clear_errors
    @errors = []
  end

  def fault
    @fault ||= Fault.new
  end

  def convert_input(input_code)
    input_code.split('').map(&:to_i)
  end

  def exact_match(input_digits, cloned_code, marked_guess, secret_code = @secret_code)
    input_digits.each_with_index do |digit, index|
      next unless digit == secret_code[index]

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
