# frozen_string_literal: true

module Gameplay
  include Registration

  class << self
    def process
      player = Registration.player_registration
      game = Game.new(player)
      result = game.start
      result[:win] ? win(player, result) : 'loss'
    end

    def win(player, result)
      Router.save_result(player, result)
      Router.start_new_game
    end
  end
end
