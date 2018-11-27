# frozen_string_literal: true

module Output
  class << self
    def introduction
      puts PhrasesList.phrase[:introduction]
    end

    def options
      puts PhrasesList.phrase[:options]
      Router.select_option(gets.chomp)
    end

    def rules
      puts PhrasesList.phrase[:rules]
      options
    end

    def exit
      puts PhrasesList.phrase[:exit]
    end

    def registration_header
      puts PhrasesList.phrase[:registration_header]
    end

    def difficulty_header
      puts PhrasesList.phrase[:difficulty_header] + ': '
    end

    def game_start
      puts PhrasesList.phrase[:codebreaker_start]
    end
  end
end
