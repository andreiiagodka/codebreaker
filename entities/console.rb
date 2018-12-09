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
      gameplay
    when RULES_COMMAND
      output.rules
      options
    when STATS_COMMAND
      rating
      options
    when EXIT_COMMAND
      output.exit
      exit
    end
  end

  private

  def gameplay
    registration
  end

  def registration
    output.registration_header
    loop do
      player = Player.new(input.player_name)
      player.validate
      player.errors.empty? ? exit : output.show(player.errors)
    end
  end

  def rating
    output.show(statistic.rating_table)
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
end
