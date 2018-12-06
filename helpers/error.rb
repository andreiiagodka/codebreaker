# frozen_string_literal: true

module Error
  class << self
    def unexpected_option
      puts error[:unexpected_option]
      Output.options
    end

    def unexpected_command
      puts error[:unexpected_command]
    end

    def player_name_length
      error[:player_name_length]
    end

    def secret_code_length
      error[:secret_code_length]
    end

    def secret_code_format
      error[:secret_code_format]
    end

    def secret_code_digit_range
      error[:secret_code_digit_range]
    end

    def hints_limit
      puts error[:hints_limit]
    end

    def attempts_limit
      puts error[:attempts_limit]
    end

    private

    def error
      Content.error
    end
  end
end
