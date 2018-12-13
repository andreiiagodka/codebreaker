# frozen_string_literal: true

class Output
  def initialize
    @output = I18n.t(:output)
  end

  def get(argument, output = @output)
    output[argument]
  end

  def statistics(game)
    puts "Used attempts: #{attempts(game)}. Used hints: #{hints(game)}."
  end

  private

  def attempts(game)
    "#{game.used_attempts}/#{game.total_attempts}"
  end

  def hints(game)
    "#{game.used_hints}/#{game.total_hints}"
  end
end
