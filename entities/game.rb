# frozen_string_literal: true

class Game
  attr_reader :player, :total_attempts, :used_attempts, :total_hints, :used_hints

  def initialize(player, used_attempts = 0, used_hints = 0)
    @total_attempts = player.difficulty[:attempts]
    @used_attempts = used_attempts
    @total_hints = player.difficulty[:hints]
    @used_hints = used_hints
  end

  private

  def increment_used_attempts
    @used_attempts += 1
  end

  def increment_used_hints
    @used_hints += 1
  end
end
