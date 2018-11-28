# frozen_string_literal: true

module Validator
  include Error

  class << self
    def player_name(player_name)
      check_player_name_length(player_name)
    end

    def secret_code(secret_code)
      return Error.secret_code_format unless check_integer(secret_code)
      return Error.secret_code_length unless check_secret_code_length(secret_code)
      return Error.secret_code_digit_range unless check_secret_code_digit_range(secret_code)
    end

    private

    def check_player_name_length(player_name)
      player_name.length.between?(USER_NAME_MIN_LENGTH, USER_NAME_MAX_LENGTH)
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
