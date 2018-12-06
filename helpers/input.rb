# frozen_string_literal: true

module Input
  class << self
    def player_name
      get_input_from_console(:player_name_registration)
    end

    def difficulty
      get_input_from_console(:difficulties)
    end

    def secret_code
      get_input_from_console(:input_secret_code)
    end

    def save_result
      get_input_from_console(:save_result)
    end

    def start_new_game
      get_input_from_console(:start_new_game)
    end

    def input
      gets.chomp
    end

    private

    def get_input_from_console(phrase)
      print Content.input[phrase] + ': '
      gets.chomp
    end
  end
end
