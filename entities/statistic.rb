# frozen_string_literal: true

class Statistic
  def initialize
    @table = I18n.t(:table)
  end
  
  # def initialize(player, game_result)
  #   @name = player.name
  #   @difficulty = player.difficulty[:difficulty]
  #   @total_attempts = game_result[:total_attempts]
  #   @used_attempts = game_result[:used_attempts]
  #   @total_hints = game_result[:total_hints]
  #   @used_hints = game_result[:used_hints]
  #   save
  # end

  def rating_table
    table = Terminal::Table.new
    table.title = @table[:title]
    table.headings = @table[:headings]
    table.rows = rows
    table
  end

  def save
    File.open(STATISTIC_YML, 'a') { |file| file.write statistic_hash.to_yaml }
  end

  private

  def rows
    load.each_with_index.map { |record, index|
      [
        index + 1,
        record[:name],
        record[:difficulty],
        record[:total_attempts],
        record[:used_attempts],
        record[:total_hints],
        record[:used_hints]
      ]
    }
  end

  def load
    YAML.load_stream(File.read(STATISTIC_YML)).sort_by { |statistic| statistic[:difficulty] }
  end

  # def statistic_hash
  #   {
  #     name: @name,
  #     difficulty: @difficulty,
  #     total_attempts: @total_attempts,
  #     used_attempts: @used_attempts,
  #     total_hints: @total_hints,
  #     used_hints: @used_hints
  #   }
  # end
end
