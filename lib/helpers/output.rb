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

  def registration_header
    show_in_console(:registration_header)
    print @output[:player_name_registration] + ': '
  end

  def game_start_header
    show_in_console(:game_start_header)
  end

  def difficulty_header
    show_in_console(:difficulty_header)
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
