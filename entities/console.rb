# frozen_string_literal: true

class Console
  def start
    output.introduction
    options
  end

  def options
    output.options
    case input.input.downcase
    when START_COMMAND
      gameplay
    when RULES_COMMAND
      output.rules
      options
    when STATS_COMMAND
      rating
      options
    when EXIT_COMMAND
      output.exit
      exit
    else
      output.show(error.unexpected_option)
      options
    end
  end

  private

  def gameplay
    player = registration
    game
  end

  def registration
    output.registration_header
    loop do
      player = Player.new(input.player_name)
      player.validate
      return player if player.errors.empty?

      output.show(player.errors)
    end
  end

  def game
    Game.new(select_difficulty)
  end

  def select_difficulty
    output.difficulty_header
    case input.difficulty.downcase
    when EASY_KEYWORD
      EASY_DIFFICULTY
    when MEDIUM_KEYWORD
      MEDIUM_DIFFICULTY
    when HARD_KEYWORD
      HARD_DIFFICULTY
    else
      output.show(error.unexpected_difficulty)
      select_difficulty
    end
  end

  def rating
    output.show(statistic.rating_table)
  end

  def statistic
    @statistic ||= Statistic.new
  end

  def output
    @output ||= Output.new
  end

  def input
    @input ||= Input.new
  end

  def error
    @error ||= Error.new
  end
end
