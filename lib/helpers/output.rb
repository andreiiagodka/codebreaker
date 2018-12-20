# frozen_string_literal: true

class Output
  def initialize
    @output = I18n.t(:output)
  end

  def show(argument)
    puts argument
  end

  def introduction
    show_in_console(:introduction)
  end

  def rules
    show_in_console(:rules)
  end

  def registration_heading
    show_in_console(:registration_heading)
    print @output[:player_name_registration] + ': '
  end

  def game_start_heading
    show_in_console(:game_start_heading)
  end

  def difficulty_heading
    show_in_console(:difficulty_heading)
  end

  def win
    show_in_console(:win)
  end

  def exit
    show_in_console(:exit)
  end

  def statistics(game)
    puts "#{@output[:used_attempts]}: #{attempts(game)}. #{@output[:used_hints]}: #{hints(game)}."
    print @output[:input_secret_code] + ': '
  end

  private

  def show_in_console(argument)
    puts @output[argument]
  end

  def attempts(game)
    "#{game.used_attempts}/#{game.total_attempts}"
  end

  def hints(game)
    "#{game.used_hints}/#{game.total_hints}"
  end
end
