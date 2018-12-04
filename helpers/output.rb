# frozen_string_literal: true

module Output
  class << self
    def introduction
      puts output[:introduction]
      options
    end

    def options
      puts output[:options]
      Router.select_option(gets.chomp)
    end

    def rules
      puts output[:rules]
      options
    end

    def exit
      puts output[:exit]
    end

    def registration_header
      puts output[:registration_header]
    end

    def difficulty_header
      puts output[:difficulty_header] + ': '
    end

    def game_start_header
      puts output[:game_start_header]
    end

    def statistics(game)
      puts "Used attempts: #{attempts(game)}. Used hints: #{hints(game)}."
    end

    def win
      puts output[:win]
    end

    private

    def output
      Content.output
    end

    def attempts(game)
      "#{game.used_attempts}/#{game.total_attempts}"
    end

    def hints(game)
      "#{game.used_hints}/#{game.total_hints}"
    end
  end
end
