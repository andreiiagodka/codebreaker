# frozen_string_literal: true

class Guess < ValidatedEntity
  attr_reader :guess_code, :errors

  SECRET_CODE_LENGTH = 4
  ELEMENT_MIN_VALUE = 1
  ELEMENT_MAX_VALUE = 6

  HINT = 'hint'

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

  def hint?
    @guess_code == HINT
  end

  private

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
