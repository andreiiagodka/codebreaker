# frozen_string_literal: true

class Console
  COMMANDS = {
    start: 'start',
    rules: 'rules',
    stats: 'stats',
    exit: 'exit'
  }.freeze

  YES_KEYWORD = 'yes'
  NO_KEYWORD = 'no'

  def menu
    output.introduction
    loop do
      output.show(options_list)
      select_option
    end
  end

  def select_option
    case user_input
    when COMMANDS[:start] then navigation
    when COMMANDS[:rules] then output.rules
    when COMMANDS[:stats] then output.show(statistic.rating_table)
    else output.show(fault.unexpected_option)
    end
  end

  def navigation
    registration
    select_difficulty
    game
  end

  def registration
    loop do
      output.registration_header
      @player = create_entity(Player)
      return if @player.is_a? Player
    end
  end

  def select_difficulty
    loop do
      output.difficulty_header
      output.show(Difficulty.list)
      @difficulty = create_entity(Difficulty)
      return if @difficulty.is_a? Difficulty
    end
  end

  def game
    output.game_start_header
    @game = Game.new(@difficulty.level)
    guess
  end

  def guess
    loop do
      output.statistics(@game)
      @guess = create_entity(Guess)
      return continue_guess if @guess.is_a? Guess
    end
  end

  def continue_guess
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

  private

  def options_list
    COMMANDS.values.map(&:capitalize)
  end

  def create_entity(klass)
    loop do
      entity = klass.new(user_input)
      return entity if entity.valid?

      return output.show(entity.errors)
    end
  end

  def user_input
    input_value = input.input.downcase
    exit?(input_value) ? exit_from_console : input_value
  end

  def exit_from_console
    output.exit
    exit
  end

  def exit?(input_value)
    input_value == COMMANDS[:exit]
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
