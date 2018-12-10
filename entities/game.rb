# frozen_string_literal: true

class Game
  attr_reader :total_attempts, :used_attempts, :total_hints, :used_hints

  def initialize(difficulty)
    @total_attempts = difficulty[:attempts]
    @used_attempts = 0
    @total_hints = difficulty[:hints]
    @used_hints = 0
  end

  def increment_used_attempts
    @used_attempts += 1
  end

  def increment_used_hints
    @used_hints += 1
  end
end
