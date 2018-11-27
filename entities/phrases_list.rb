# frozen_string_literal: true

class PhrasesList
  def initialize
    @@phrases = load_phrases
  end

  def self.phrase
    @@phrases
  end

  private

  def load_phrases
    YAML.load_stream(File.read(PHRASES_YML)).first
  end
end
