# frozen_string_literal: true

module Gameplay
  include Registration

  class << self
    def process
      player = Registration.player_registration
      game = Game.new(player)
      game.start
    end
  end
end
