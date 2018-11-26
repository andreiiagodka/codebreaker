# frozen_string_literal: true

module Gameplay
  include Registration

  class << self
    def process
      player = Registration.player_registration
      Game.new(player)
    end
  end
end
