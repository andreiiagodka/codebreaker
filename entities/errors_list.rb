# frozen_string_literal: true

class ErrorsList
  def initialize
    @@errors = load_errors
  end

  def self.error
    @@errors
  end

  private

  def load_errors
    YAML.load_stream(File.read(ERRORS_YML)).first
  end
end
