# frozen_string_literal: true

module ConsoleUserInteraction
  ENTITIES = {
    player: 'Player',
    difficulty: 'Difficulty',
    guess: 'Guess'
  }.freeze

  def options_list
    Console::COMMANDS.values.map(&:capitalize)
  end

  def user_input
    input_value = gets.chomp.downcase
    exit?(input_value) ? exit_from_console : input_value
  end

  def exit_from_console
    output.exit
    exit
  end

  def create_entity(klass)
    loop do
      class_heading(klass)
      entity = klass.new(user_input)
      return entity if entity.valid?

      output.display(entity.errors)
    end
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

  private

  def class_heading(klass)
    case klass.to_s
    when ENTITIES[:player] then output.registration
    when ENTITIES[:difficulty] then output.difficulty_heading
    when ENTITIES[:guess] then output.statistics(@game)
    end
  end

  def exit?(input_value)
    input_value == Console::COMMANDS[:exit]
  end
end
