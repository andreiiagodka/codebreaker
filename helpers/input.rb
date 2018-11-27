# frozen_string_literal: true

module Input
  class << self
    def player_name
      print PhrasesList.phrase[:player_name_registration] + ': '
      gets.chomp
    end

    def difficulty
      puts PhrasesList.phrase[:difficulties]
      gets.chomp
    end

    def secret_code
      print PhrasesList.phrase[:input_secret_code] + ': '
      gets.chomp
    end
  end
end
