# frozen_string_literal: true

module Validator
  class << self
    def check_name_length(argument)
      argument.length.between?(NAME_MIN_LENGTH, NAME_MAX_LENGTH)
    end

    def check_integer(argument)
      true if Integer(argument) rescue false
    end

    def check_hints_quantity(game)
      game.used_hints >= game.total_hints
    end

    def check_attempts_quantity(game)
      game.used_attempts == game.total_attempts
    end

    def check_hint(argument)
      argument == HINT_COMMAND
    end

    def check_secret_code_length(argument)
      argument.length == SECRET_CODE_LENGTH
    end

    def check_win_combination(argument)
      argument == WIN_COMBINATION
    end

    def check_secret_code_digits_range(argument)
      argument.each_char { |digit| break unless digit.to_i.between?(ELEMENT_MIN_VALUE, ELEMENT_MAX_VALUE) }
    end
  end
end
