# frozen_string_literal: true

class Console
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

  ENTITIES = {
    player: 'Player',
    difficulty: 'Difficulty',
    guess: 'Guess'
  }.freeze

  def menu
    output.introduction
    loop do
      output.output(options_list)
      select_option
    end
  end

  private

  def select_option
    case user_input
    when COMMANDS[:start] then navigation
    when COMMANDS[:rules] then output.rules
    when COMMANDS[:stats] then output.output(statistic.rating_table)
    else output.output(failing.unexpected_option)
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
    @game.hints_available? ? output.output(failing.hints_limit) : output.output(@game.use_hint)
  end

  def guess_result
    @game.increment_used_attempts
    return win if @game.win?(@guess.guess_code)
    return loss if @game.loss?

    marked_guess = @game.mark_guess(@guess.guess_code)
    output.output(marked_guess)
  end

  def win
    output.win
    save_result
    start_new_game
  end

  def loss
    output.output(failing.attempts_limit)
    start_new_game
  end

  def save_result
    output.save_result
    loop do
      case user_input
      when KEYWORDS[:yes] then return statistic.save(@player, @game)
      when KEYWORDS[:no] then return
      else output.output(failing.unexpected_command)
      end
    end
  end

  def start_new_game
    output.start_new_game
    loop do
      case user_input
      when KEYWORDS[:yes] then menu
      when KEYWORDS[:no] then exit_from_console
      else output.output(failing.unexpected_command)
      end
    end
  end

  def options_list
    COMMANDS.values.map(&:capitalize)
  end

  def create_entity(klass)
    loop do
      class_heading(klass)
      entity = klass.new(user_input)
      return entity if entity.valid?

      output.output(entity.errors)
    end
  end

  def class_heading(klass)
    case klass.to_s
    when ENTITIES[:player] then output.registration
    when ENTITIES[:difficulty] then output.difficulty_heading
    when ENTITIES[:guess] then output.statistics(@game)
    end
  end

  def user_input
    input_value = gets.chomp.downcase
    exit?(input_value) ? exit_from_console : input_value
  end

  def exit?(input_value)
    input_value == COMMANDS[:exit]
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

  def failing
    @failing ||= Failing.new
  end
end
