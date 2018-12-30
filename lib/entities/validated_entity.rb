# frozen_string_literal: true

class ValidatedEntity
  def initialize
    @errors = []
  end

  def validate
    raise NotImplementedError
  end

  def valid?
    validate
    @errors.empty?
  end

  def failing
    @failing ||= Failing.new
  end
end
