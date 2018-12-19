# frozen_string_literal: true

class ConsoleMemorization
  YES_KEYWORD = 'yes'
  NO_KEYWORD = 'no'

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
