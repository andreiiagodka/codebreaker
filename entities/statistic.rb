# frozen_string_literal: true

class Statistic
  def initialize(player, game_result)
    @name = player.name
    @difficulty = player.difficulty[:difficulty]
    @total_attempts = game_result[:total_attempts]
    @used_attempts = game_result[:used_attempts]
    @total_hints = game_result[:total_hints]
    @used_hints = game_result[:used_hints]
    save
  end

  def self.show
    Statistic.load.each_with_index { |record, index|
      Output.show("Rating: #{index + 1}")
      Output.show("- name: #{record[:name]}")
      Output.show("- difficulty: #{record[:difficulty]}")
      Output.show("- total_attempts: #{record[:total_attempts]}")
      Output.show("- used_attempts: #{record[:used_attempts]}")
      Output.show("- total_hints: #{record[:total_hints]}")
      Output.show("- used_hints: #{record[:used_hints]}")
    }
  end

  private

  def save
    File.open(STATISTIC_YML, 'a') { |file| file.write statistic_hash.to_yaml }
  end

  def self.load
    YAML.load_stream(File.read(STATISTIC_YML)).sort_by { |statistic| statistic[:difficulty] }
  end

  def statistic_hash
    {
      name: @name,
      difficulty: @difficulty,
      total_attempts: @total_attempts,
      used_attempts: @used_attempts,
      total_hints: @total_hints,
      used_hints: @used_hints
    }
  end
end
