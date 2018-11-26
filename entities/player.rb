# frozen_string_literal: true

class Player
  attr_reader :name, :difficulty

  def initialize(name, difficulty)
    @name = name
    @difficulty = difficulty
  end
end
