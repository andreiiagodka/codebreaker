# frozen_string_literal: true

class Player < ValidatedEntity
  attr_reader :name, :errors

  NAME_MIN_LENGTH = 3
  NAME_MAX_LENGTH = 20

  def initialize(name)
    super()
    @name = name
  end

  def validate
    @errors << fault.player_name_length(NAME_MIN_LENGTH, NAME_MAX_LENGTH) unless check_name_length
  end

  private

  def check_name_length
    @name.length.between?(NAME_MIN_LENGTH, NAME_MAX_LENGTH)
  end
end
