# frozen_string_literal: true

class Content
  def initialize
    @@content = load
  end

  class << self
    def output
      @@content[:output]
    end

    def input
      @@content[:input]
    end

    def error
      @@content[:error]
    end
  end

  private

  def load
    YAML.load_stream(File.read(CONTENT_YML)).first
  end
end
