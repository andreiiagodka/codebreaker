# frozen_string_literal: true

class Console
  def start
    output.introduction
    options
  end

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
    when STATS_COMMAND then output.show(statistic.rating_table)
    when EXIT_COMMAND then exit_from_console
    else output.show(fault.unexpected_option)
    end
  end

  def gameplay
    player = registration
    score = game
    save_result(player, score) if score
    start_new_game
  end

  def registration
    loop do
      output.registration_header
      entity = validate_entity(Player)
      return entity if entity.is_a? Player
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
      else output.show(fault.unexpected_difficulty)
      end
    end
  end

  def save_result(player, score)
    loop do
      case input.save_result
      when YES_KEYWORD then return statistic.save(player, score)
      when NO_KEYWORD then return
      else output.show(fault.unexpected_command)
      end
    end
  end

  def start_new_game
    loop do
      case input.start_new_game
      when YES_KEYWORD then start
      when NO_KEYWORD then exit_from_console
      else output.show(fault.unexpected_command)
      end
    end
  end

  def guess(game)
    loop do
      output.statistics(game)
      input_code = guess_secret_code(game)
      marked_guess = game.mark_guess(input_code)
      if game.win?(marked_guess)
        output.win
        return game
      end
      puts marked_guess
      return output.show(fault.attempts_limit) if game.loss?
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

  # def continue_attempt(guess, game)
  #   marked_guess = guess.mark_guess(game.secret_code)
  #   output.show(marked_guess)
  #   return win(game) if game.win?(marked_guess)
  #   return loss if game.loss?
  # end

  def show_hint(game)
    return output.show(fault.hints_limit) if game.hints_limit?

    output.statistics(game)
    output.show(game.use_hint)
  end

  def validate_entity(klass)
    loop do
      entity = klass.new(user_input)
      return entity if entity.valid?

      return output.show(entity.errors)
    end
  end

  def user_input
    input_value = input.input
    Validator.check_hint(input_value) ? exit_from_console : input_value
  end

  def win(game)
    output.win
    save_result(@player, game)
    start_new_game
  end

  def loss
    output.show(fault.attempts_limit)
    start_new_game
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
