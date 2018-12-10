# frozen_string_literal: true

class Error
  def initialize
    @error = I18n.t(:error)
  end

  def unexpected_option
    error(:unexpected_option)
  end

  def unexpected_command
    error(:unexpected_command)
  end

  def unexpected_difficulty
    error(:unexpected_difficulty)
  end

  def player_name_length
    error(:player_name_length)
  end

  def secret_code_length
    error(:secret_code_length)
  end

  def secret_code_format
    error(:secret_code_format)
  end

  def secret_code_digits_range
    error(:secret_code_digits_range)
  end

  def hints_limit
    error(:hints_limit)
  end

  def attempts_limit
    error(:attempts_limit)
  end

  private

  def error(argument)
    @error[argument]
  end
end
