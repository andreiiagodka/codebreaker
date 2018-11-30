# frozen_string_literal: true

module Input
  class << self
    def player_name
      print input[:player_name_registration] + ': '
      gets.chomp
    end

    def difficulty
      puts input[:difficulties]
      gets.chomp
    end

    def secret_code
      print input[:input_secret_code] + ': '
      gets.chomp
    end

    print

    def input
      Content.input
    end
  end
end
