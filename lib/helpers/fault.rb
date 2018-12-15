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

  def player_name_length
    get(:player_name_length)
  end

  def secret_code_format
    get(:secret_code_format)
  end

  def secret_code_length
    get(:secret_code_length)
  end

  def secret_code_digits_range
    get(:secret_code_digits_range)
  end

  private

  def get(argument, fault = @fault)
    fault[argument]
  end
end
