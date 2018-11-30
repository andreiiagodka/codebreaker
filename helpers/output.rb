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

    private

    def output
      Content.output
    end
  end
end
