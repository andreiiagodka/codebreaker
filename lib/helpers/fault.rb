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

  def secret_code_format
    get(:secret_code_format)
  end

  def hints_limit
    get(:hints_limit)
  end

  def player_name_length(min, max)
    get_with_parameters(:player_name_length, min_length: min, max_length: max)
  end

  def secret_code_length(code_length)
    get_with_parameters(:secret_code_length, code_length: code_length)
  end

  def secret_code_digits_range(min_value, max_value)
    get_with_parameters(:secret_code_digits_range, min_value: min_value, max_value: max_value)
  end

  private

  def get(argument)
    @fault[argument]
  end

  def get_with_parameters(argument, *parameters)
    I18n.t('fault.' + argument.to_s, *parameters)
  end
end
