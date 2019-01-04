# frozen_string_literal: true

class Console
  include ConsoleUserInteraction

  COMMANDS = {
    start: 'start',
    rules: 'rules',
    stats: 'stats',
    exit: 'exit'
  }.freeze

  KEYWORDS = {
    yes: 'yes',
    no: 'no'
  }.freeze

  def menu
    output.introduction
    loop do
      output.display(options_list)
      select_option
    end
  end

  private

  def select_option
    case user_input
    when COMMANDS[:start] then navigation
    when COMMANDS[:rules] then output.rules
    when COMMANDS[:stats] then output.display(statistic.rating_table)
    else failing.unexpected_option
    end
  end

  def navigation
    @player = create_entity(Player)
    @difficulty = create_entity(Difficulty)
    game_process
  end

  def game_process
    output.game_start_heading
    @game = Game.new(@difficulty.level)
    make_guess
  end

  def make_guess
    loop do
      @guess = create_entity(Guess)
      @guess.hint? ? output_hint : guess_result
    end
  end

  def output_hint
    @game.hints_available? ? output.display(failing.hints_limit) : output.display(@game.use_hint)
  end

  def guess_result
    @game.increment_used_attempts
    return win if @game.win?(@guess.guess_code)
    return loss if @game.loss?

    marked_guess = @game.mark_guess(@guess.guess_code)
    output.display(marked_guess)
  end

  def win
    output.win
    save_result
    start_new_game
  end

  def loss
    output.display(failing.attempts_limit)
    start_new_game
  end

  def save_result
    output.save_result
    loop do
      case user_input
      when KEYWORDS[:yes] then return statistic.save(@player, @game)
      when KEYWORDS[:no] then return
      else failing.unexpected_command
      end
    end
  end

  def start_new_game
    output.start_new_game
    loop do
      case user_input
      when KEYWORDS[:yes] then menu
      when KEYWORDS[:no] then exit_from_console
      else failing.unexpected_command
      end
    end
  end
end
