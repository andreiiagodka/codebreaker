# frozen_string_literal: true

module Output
  class << self
    def introduction
      puts INTRODUCTION
    end

    def options
      puts OPTIONS
      Router.select_option(gets.chomp)
    end

    def rules
      puts RULES
      options
    end

    def exit
      puts EXIT
    end

    def unexpected_option
      puts UNEXPECTED_OPTION
      options
    end
  end
end
