# frozen_string_literal: true

module Registration
  include Output

  class << self
    def registrate
      Output.registration_header
      user_name = input_player_name
      difficulty = input_difficulty
      User.new(user_name, difficulty[:attempts], difficulty[:hints])
    end

    def input_player_name
      loop do
        user_name = Output.input_player_name
        return user_name if validate_player_name(user_name)
      end
    end

    def input_difficulty
      Output.difficulty_header
      loop do
        difficulty = Output.input_difficulty
        chosen_difficulty = choose_difficulty(difficulty)
        return chosen_difficulty.first if chosen_difficulty
      end
    end

    private

    def validate_player_name(name)
      !name.empty? && name.length.between?(USER_NAME_MIN_SIZE, USER_NAME_MAX_SIZE)
    end

    def choose_difficulty(difficulty)
      case difficulty.downcase
      when 'easy' then EASY_DIFFICULTY
      when 'medium' then MEDIUM_DIFFICULTY
      when 'hard' then HARD_DIFFICULTY
      end
    end
  end
end
