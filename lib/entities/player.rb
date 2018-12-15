# frozen_string_literal: true

class Player < ValidatedEntity
  attr_reader :name, :errors

  def initialize(name)
    super()
    @name = name
  end

  def validate
    @errors << fault.player_name_length unless Validator.check_name_length(@name)
  end

  private

  def fault
    @fault ||= Fault.new
  end
end
