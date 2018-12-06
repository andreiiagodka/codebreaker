# frozen_string_literal: true

module Output
  class << self
    def show(argument)
      puts argument
    end

    def introduction
      show(output[:introduction])
      options
    end

    def options
      show(output[:options])
      Router.select_option(gets.chomp)
    end

    def rules
      show(output[:rules])
      options
    end

    def exit
      show(output[:exit])
    end

    def registration_header
      show(output[:registration_header])
    end

    def difficulty_header
      show(output[:difficulty_header] + ': ')
    end

    def game_start_header
      show(output[:game_start_header])
    end

    def statistics(game)
      show("Used attempts: #{attempts(game)}. Used hints: #{hints(game)}.")
    end

    def win
      show(output[:win])
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
