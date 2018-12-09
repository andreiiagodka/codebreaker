# frozen_string_literal: true

class Console
  def start
    output.introduction
    options
  end

  def options
    output.options
    case input.input.downcase
    when START_COMMAND
      puts 'start'
    when RULES_COMMAND
      output.rules
      options
    when STATS_COMMAND
      output.show(statistic.rating_table)
      options
    when EXIT_COMMAND
      output.exit
      exit
    end
  end

  private

  def statistic
    @statistic ||= Statistic.new
  end

  def output
    @output ||= Output.new
  end

  def input
    @input ||= Input.new
  end
end
