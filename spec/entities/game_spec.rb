# frozen_string_literal: true

RSpec.describe Game do
  subject(:game) { described_class.new(difficulty) }

  let(:difficulty) { Difficulty::DIFFICULTIES[:easy] }
  let(:hints_limit) { game.total_hints }
  let(:attempts_limit) { game.total_attempts }
  let(:win_combination) { Game::WIN_COMBINATION }
  let(:not_win_combination) { '++--' }

  describe '.new' do
    it { expect(game.difficulty).to eq(difficulty[:level]) }
    it { expect(game.total_attempts).to eq(difficulty[:attempts]) }
    it { expect(game.used_attempts).to eq(0) }
    it { expect(game.total_hints).to eq(difficulty[:hints]) }
    it { expect(game.used_hints).to eq(0) }
  end

  describe '#use_hint' do
    it do
      allow(game).to receive(:increment_used_hints)
    end
  end

  describe '#hints_limit?' do
    context 'when returns true' do
      it do
        game.instance_variable_set(:@used_hints, hints_limit)
        expect(game.used_hints).to be >= game.total_hints
      end
    end

    context 'when returns false' do
      it do
        expect(game.hints_limit?).to eq false
      end
    end
  end

  describe '#win?' do
    context 'when returns true' do
      it { expect(win_combination).to eq Game::WIN_COMBINATION }
    end

    context 'when returns false' do
      it { expect(not_win_combination).not_to eq Game::WIN_COMBINATION }
    end
  end

  describe '#loss?' do
    context 'when returns true' do
      it do
        game.instance_variable_set(:@used_attempts, attempts_limit)
        expect(game.used_attempts).to eq game.total_attempts
      end
    end

    context 'when returns false' do
      it { expect(game.used_attempts).not_to eq game.total_attempts }
    end
  end
end
