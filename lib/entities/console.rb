# frozen_string_literal: true

class Console < ConsoleMemorization
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
    case user_input
    when COMMANDS[:start] then registration
    when COMMANDS[:rules] then output.rules
    when COMMANDS[:stats] then output.show(statistic.rating_table)
    else output.show(fault.unexpected_option)
    end
  end

  def registration
    loop do
      output.registration_header
      @player = validate_entity(Player)
      return select_difficulty if @player.is_a? Player
    end
  end

  def select_difficulty
    loop do
      output.difficulty_header
      @difficulty = validate_entity(Difficulty)
      return game if @difficulty.is_a? Difficulty
    end
  end

  def game
    @game = Game.new(@difficulty.level)
    output.game_start_header
    guess
  end

  def guess
    loop do
      output.statistics(@game)
      @guess = validate_entity(Guess)
      return guess_continue if @guess.is_a? Guess
    end
  end

  def guess_continue
    @guess.hint? ? show_hint : guess_result
    guess
  end

  def show_hint
    @game.hints_limit? ? output.show(fault.hints_limit) : output.show(@game.use_hint)
  end

  def guess_result
    @game.increment_used_attempts
    marked_guess = @guess.mark_guess(@game.secret_code)
    output.show(marked_guess)
    return win if @game.win?(marked_guess)
    return loss if @game.loss?
  end

  def win
    output.win
    save_result
    start_new_game
  end

  def loss
    output.show(fault.attempts_limit)
    start_new_game
  end

  def save_result
    loop do
      case input.save_result
      when YES_KEYWORD then return statistic.save(@player, @game)
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
end
