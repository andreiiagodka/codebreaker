# frozen_string_literal: true

class Statistic
  def initialize(player, game_result)
    @name = player.name
    @difficulty = player.difficulty[:difficulty]
    @total_attempts = game_result[:total_attempts]
    @used_attempts = game_result[:used_attempts]
    @total_hints = game_result[:total_hints]
    @used_hints = game_result[:used_hints]
    save
  end

  def save
    File.open(STATISTIC_YML, 'a') { |file| file.write self.to_yaml }
  end
end
