# frozen_string_literal: true

class User
  attr_reader :name, :attempts, :hints

  def initialize(name, attempts, hints)
    @name = name
    @attempts = attempts
    @hints = hints
  end
end
