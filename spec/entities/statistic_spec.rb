# frozen_string_literal: true

RSpec.describe Statistic do
  subject(:statistic) { described_class.new }
  let(:terminal_table) { Terminal::Table.new }

  let(:player_double) { instance_double('Player', name: valid_name) }
  let(:game_double) do
    instance_double('Game',
      difficulty: Difficulty::DIFFICULTIES[:easy][:level],
      total_attempts: Difficulty::DIFFICULTIES[:easy][:attempts],
      used_attempts: 0,
      total_hints: Difficulty::DIFFICULTIES[:easy][:hints],
      used_hints: 0
    )
  end
  let(:record_double) do
    {
      name: player_double.name,
      difficulty: game_double.difficulty,
      total_attempts: game_double.total_attempts,
      used_attempts: game_double.used_attempts,
      total_hints: game_double.total_hints,
      used_hints: game_double.used_hints
    }
  end

  let(:valid_name) { 'a' * Player::NAME_MIN_LENGTH }

  describe '.new' do
    it { expect(statistic.instance_variable_get(:@table)).to eq(I18n.t(:table)) }
  end

  describe '#save' do
    it do
      allow(statistic).to receive(:record).with(player_double, game_double)
      allow(statistic).to receive(:save_to_file).with(record_double)
    end
  end

  describe '#rating_table' do
    it do
      expect(statistic).to receive(:terminal_table)
      statistic.send(:terminal_table)
      expect(terminal_table).to receive(:title)
      terminal_table.send(:title)
      expect(terminal_table).to receive(:headings)
      terminal_table.send(:headings)
      expect(terminal_table).to receive(:rows)
      terminal_table.send(:rows)
    end
  end
end
