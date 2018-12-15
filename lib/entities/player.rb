# frozen_string_literal: true

class Player
  attr_reader :name, :errors

  def initialize(name)
    @name = name
    @errors = []
  end

  def validate(name = @name)
    @errors << fault.player_name_length unless Validator.check_name_length(name)
  end

  private

  def fault
    @fault ||= Fault.new
  end
end
