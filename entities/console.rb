# frozen_string_literal: true

class Console
  def start
    output.introduction
    options
  end

  private

  def options
    loop do
      output.options
      option_cases
    end
  end

  def option_cases
    case input.input.downcase
    when START_COMMAND then gameplay
    when RULES_COMMAND then output.rules
    when STATS_COMMAND then puts statistic.rating_table
    when EXIT_COMMAND then exit_from_console
    else puts fault.get(:unexpected_option)
    end
  end

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

      puts player.errors
    end
  end

  def game
    game = Game.new(select_difficulty)
    output.game_start_header
    guess(game)
  end

  def select_difficulty
    loop do
      output.difficulty_header
      case input.difficulty.downcase
      when EASY_KEYWORD then return EASY_DIFFICULTY
      when MEDIUM_KEYWORD then return MEDIUM_DIFFICULTY
      when HARD_KEYWORD then return HARD_DIFFICULTY
      else puts fault.get(:unexpected_difficulty)
      end
    end
  end

  def save_result(player, score)
    loop do
      case input.save_result
      when YES_KEYWORD then return statistic.save(player, score)
      when NO_KEYWORD then return
      else fault.unexpected_command
      end
    end
  end

  def start_new_game
    loop do
      case input.start_new_game
      when YES_KEYWORD then start
      when NO_KEYWORD then exit_from_console
      else fault.unexpected_command
      end
    end
  end

  def guess(game)
    loop do
      output.statistics(game)
      input_code = guess_secret_code(game)
      mark_guess = game.mark_guess(input_code)
      if Validator.check_win_combination(mark_guess)
        output.win
        return game
      end
      puts mark_guess
      return puts fault.get(:attempts_limit) if Validator.check_attempts_quantity(game)
    end
  end

  def guess_secret_code(game)
    loop do
      input_code = input.secret_code
      next use_hint(game) if Validator.check_hint(input_code)

      game.validate_secret_code(input_code)
      return input_code if game.errors.empty?

      puts game.errors
      input_code
    end
  end

  def use_hint(game)
    return puts fault.get(:hints_limit) if Validator.check_hints_quantity(game)

    output.statistics(game)
    puts game.hint
  end

  def exit_from_console
    output.exit
    exit
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

  def fault
    @fault ||= Fault.new
  end
end
