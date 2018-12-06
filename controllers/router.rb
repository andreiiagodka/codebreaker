# frozen_string_literal: true

module Router
  class << self
    def select_option(option)
      case option.downcase
      when START_KEYWORD
        Gameplay.process
      when RULES_KEYWORD
        Output.rules
      when STATS_KEYWORD
        puts 'its stats'
      when EXIT_KEYWORD
        Output.exit
      else Error.unexpected_option
      end
    end

    def save_result
      loop do
        case Input.save_result
        when YES_KEYWORD
          Statistic.new(player, result)
        when NO_KEYWORD
          return Output.exit
        else Error.unexpected_command
        end
      end
    end

    def start_new_game
      loop do
        case Input.start_new_game
        when YES_KEYWORD
          Gameplay.process
        when NO_KEYWORD
          return Output.exit
        else Error.unexpected_command
        end
      end
    end
  end
end
