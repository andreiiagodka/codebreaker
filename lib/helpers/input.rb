# frozen_string_literal: true

class Input
  def initialize
    @input = I18n.t(:input)
  end

  def input
    gets.chomp.downcase
  end

  def save_result
    get_input_from_console(:save_result)
  end

  def start_new_game
    get_input_from_console(:start_new_game)
  end

  private

  def get_input_from_console(phrase)
    print @input[phrase] + ': '
    gets.chomp
  end
end
