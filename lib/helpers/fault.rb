# frozen_string_literal: true

class Fault
  def initialize
    @fault = I18n.t(:fault)
  end

  def unexpected_option
    get(:unexpected_option)
  end

  def unexpected_difficulty
    get(:unexpected_difficulty)
  end

  def unexpected_command
    get(:unexpected_command)
  end

  def attempts_limit
    get(:attempts_limit)
  end

  def player_name_length(min, max)
    get(:player_name_length, min_length: min, max_length: max)
  end

  def secret_code_format
    get(:secret_code_format)
  end

  def secret_code_length(code_length)
    "#{code_length} " + get(:secret_code_length)
  end

  def secret_code_digits_range(min_value, max_value)
    get(:secret_code_digits_range) + " #{min_value}-#{max_value}"
  end

  def hints_limit
    get(:hints_limit)
  end

  private

  def get(argument)
    @fault[argument]
  end
end
