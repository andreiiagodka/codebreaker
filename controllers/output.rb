# frozen_string_literal: true

module Output
  class << self
    def introduction
      puts Message.phrase[:introduction]
    end

    def options
      puts Message.phrase[:options]
      Router.select_option(gets.chomp)
    end

    def rules
      puts Message.phrase[:rules]
      options
    end

    def exit
      puts Message.phrase[:exit]
    end

    def unexpected_option
      puts Message.phrase[:unexpected_option]
      options
    end

    def registration_header
      puts Message.phrase[:registration_header]
    end

    def input_player_name
      print Message.phrase[:player_name_registration] + ': '
      gets.chomp
    end

    def difficulty_header
      puts Message.phrase[:difficulty_header]
    end

    def input_difficulty
      puts Message.phrase[:difficulties]
      gets.chomp
    end
  end
end
