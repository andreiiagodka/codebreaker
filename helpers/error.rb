# frozen_string_literal: true

module Error
  class << self
    def unexpected_option
      puts ErrorsList.error[:unexpected_option]
      Output.options
    end

    def player_name_length
      ErrorsList.error[:player_name_length]
    end

    def secret_code_length
      ErrorsList.error[:secret_code_length]
    end

    def secret_code_format
      ErrorsList.error[:secret_code_format]
    end

    def secret_code_digit_range
      ErrorsList.error[:secret_code_digit_range]
    end
  end
end
