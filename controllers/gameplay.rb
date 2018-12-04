# frozen_string_literal: true

module Gameplay
  include Registration

  class << self
    def process
      player = Registration.player_registration
      game = Game.new(player)
      result = game.start
      puts result
    end
  end
end
