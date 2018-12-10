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
    score = game
    save_result(player, score) if score
    start_new_game
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
    guess(game)
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

  def guess(game)
    puts secret_code.secret_code
    loop do
      output.statistics(game)
      input_code = guess_secret_code(game)
      game.increment_used_attempts
      mark_guess = secret_code.mark_guess(input_code)
      if Validator.check_win_combination(mark_guess)
        output.win
        return game
      end

      output.show(mark_guess)
      if Validator.check_attempts_quantity(game)
        output.show(error.attempts_limit)
        return
      end
    end
  end

  def rating
    output.show(statistic.rating_table)
  end

  def save_result(player, score)
    loop do
      case input.save_result
      when YES_KEYWORD
        statistic.save(player, score)
        return
      when NO_KEYWORD
        return
      else
        output.show(error.unexpected_command)
      end
    end
  end

  def start_new_game
    loop do
      case input.start_new_game
      when YES_KEYWORD
        start
      when NO_KEYWORD
        output.exit
        exit
      else
        output.show(error.unexpected_command)
      end
    end
  end

  def guess_secret_code(game)
    loop do
      input_code = input.secret_code
      secret_code.validate(input_code)
      next use_hint(game) if Validator.check_hint(input_code)
      return input_code if secret_code.errors.empty?

      output.show(secret_code.errors)
      input_code
    end
  end

  def use_hint(game)
    return output.show(error.hints_limit) if Validator.check_hints_quantity(game)

    game.increment_used_hints
    output.statistics(game)
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
