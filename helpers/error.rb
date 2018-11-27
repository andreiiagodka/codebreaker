# frozen_string_literal: true

module Error
  class << self
    def unexpected_option
      puts ErrorsList.error[:unexpected_option]
      Output.options
    end
  end
end
