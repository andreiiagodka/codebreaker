# frozen_string_literal: true

module Registration
  class << self
    def player_registration
      Output.registration_header
      player_name = input_player_name
      difficulty = input_difficulty
      Player.new(player_name, difficulty)
    end

    def input_player_name
      loop do
        user_name = Input.player_name
        return user_name if Validator.player_name(user_name)
      end
    end

    def input_difficulty
      Output.difficulty_header
      loop do
        difficulty = Input.difficulty
        chosen_difficulty = choose_difficulty(difficulty)
        return chosen_difficulty.first if chosen_difficulty
      end
    end

    private

    def choose_difficulty(difficulty)
      case difficulty.downcase
      when 'easy' then EASY_DIFFICULTY
      when 'medium' then MEDIUM_DIFFICULTY
      when 'hard' then HARD_DIFFICULTY
      end
    end
  end
end
