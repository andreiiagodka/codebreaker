# frozen_string_literal: true

module Router
  class << self
    def select_option(option)
      case option.downcase
      when START_KEYWORD then Gameplay.process
      when RULES_KEYWORD then Output.rules
      when STATS_KEYWORD then puts 'its stats'
      when EXIT_KEYWORD then Output.exit
      else Error.unexpected_option
      end
    end
  end
end
