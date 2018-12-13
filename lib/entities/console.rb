# frozen_string_literal: true

class Console
  def start
    puts output.get(:introduction)
    options
  end

  private

  def options
    loop do
      puts output.get(:options)
      option_cases
    end
  end

  def option_cases
    case input.input.downcase
    when START_COMMAND then gameplay
    when RULES_COMMAND then puts output.get(:rules)
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
    puts output.get(:registration_header)
    loop do
      player = Player.new(input.player_name)
      player.validate
      return player if player.errors.empty?

      puts player.errors
    end
  end

  def game
    game = Game.new(select_difficulty)
    puts output.get(:game_start_header)
    guess(game)
  end

  def select_difficulty
    loop do
      puts output.get(:difficulty_header)
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
      marked_guess = game.mark_guess(input_code)
      if game.win?(marked_guess)
        puts output.get(:win)
        return game
      end
      puts marked_guess
      return puts fault.get(:attempts_limit) if game.loss?
    end
  end

  def guess_secret_code(game)
    loop do
      input_code = input.secret_code
      next show_hint(game) if game.hint?(input_code)

      game.validate_secret_code(input_code)
      return input_code if game.errors.empty?

      puts game.errors
      input_code
    end
  end

  def show_hint(game)
    return puts fault.get(:hints_limit) if game.hints_limit?

    output.statistics(game)
    puts game.use_hint
  end

  def exit_from_console
    puts output.get(:exit)
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
