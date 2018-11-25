# frozen_string_literal: true

module Game
  include Registration
  
  class << self
    def process
      Registration.registrate
    end
  end
end
