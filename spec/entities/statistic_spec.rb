# frozen_string_literal: true

RSpec.describe Statistic do
  subject(:statistic) { described_class.new }

  let(:table_phrases_section) { I18n.t(:table) }
  let(:path) { 'database/test_statistic.yml' }
  let(:statistic_double) { instance_double('StatisticsRecords') }
  let(:difficulty) { Difficulty::DIFFICULTIES.values.sample }

  let(:player) { instance_double('Player', name: 'a' * Player::NAME_LENGTH_RANGE.max) }
  let(:score) do
    instance_double('Game',
                    difficulty: difficulty[:level],
                    total_attempts: difficulty[:attempts],
                    used_attempts: 0,
                    total_hints: difficulty[:hints],
                    used_hints: 0)
  end

  let(:record_hash) do
    {
      name: player.name,
      difficulty: score.difficulty,
      total_attempts: score.total_attempts,
      used_attempts: score.used_attempts,
      total_hints: score.total_hints,
      used_hints: score.used_hints
    }
  end

  before do
    File.new(path, 'w+')
    stub_const('Statistic::STATISTIC_YML', path)
  end

  after { File.delete(path) }

  describe '#new' do
    it { expect(statistic.instance_variable_get(:@table)).to eq(table_phrases_section) }
  end

  describe '#save_to_file' do
    it { expect { statistic.save(player, score) }.to change { statistic.send(:load).count }.by(1) }
  end

  describe '#load' do
    before { statistic.save(player, score) }

    it 'statistic file is not empty' do
      expect(statistic.send(:load).empty?).to eq(false)
    end
  end
end
