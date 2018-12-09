# frozen_string_literal: true

module Validator
  class << self
    def check_name_length(name)
      name.length.between?(NAME_MIN_LENGTH, NAME_MAX_LENGTH)
    end

    def secret_code(secret_code)
      return Error.secret_code_format unless check_integer(secret_code)
      return Error.secret_code_length unless check_secret_code_length(secret_code)
      return Error.secret_code_digit_range unless check_secret_code_digit_range(secret_code)
    end

    private


    def check_hint(secret_code)
      secret_code == HINT_KEYWORD
    end

    def check_integer(argument)
      true if Integer(argument) rescue false
    end

    def check_secret_code_length(secret_code)
      secret_code.length == SECRET_CODE_LENGTH
    end

    def check_secret_code_digit_range(secret_code)
      secret_code.each_char { |digit| break unless digit.to_i.between?(ELEMENT_MIN_VALUE, ELEMENT_MAX_VALUE) }
    end
  end
end
