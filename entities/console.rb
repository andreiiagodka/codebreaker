# frozen_string_literal: true
require 'pry'
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
    game = Game.new(select_difficulty)
    output.game_start_header
    guess(game, secret_code.secret_code)
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

  def guess(game, code)
    loop do
      guess_secret_code(game)
    end
  end

  def rating
    output.show(statistic.rating_table)
  end

  def guess_secret_code(game)
    loop do
      output.statistics(game)
      input_code = input.secret_code
      secret_code.validate(input_code)
      next use_hint(game) if Validator.check_hint(input_code)
      return input_code if secret_code.errors.empty?

      output.show(secret_code.errors)
    end
  end

  def use_hint(game)
    return output.show(error.hints_limit) if Validator.check_hints_quantity(game)

    game.increment_used_hints
    output.show(secret_code.hint)
  end

  def statistic
    @statistic ||= Statistic.new
  end

  def secret_code
    @secret_code ||= SecretCode.new
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
