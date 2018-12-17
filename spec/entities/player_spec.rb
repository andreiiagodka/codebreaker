# frozen_string_literal: true

RSpec.describe Player do
  subject(:player) { described_class.new(valid_name) }
  let(:fault) { Fault.new }

  let(:valid_name) { 'a' * Player::NAME_MIN_LENGTH }
  let(:empty_string) { '' }

  describe '.new' do
    it { expect(player.name).to eq(valid_name) }
    it { expect(player.instance_variable_get(:@errors)).to eq([]) }
  end

  describe 'valid' do
    before { player.validate }

    context 'when #validate true' do
      it { expect(player.errors.empty?).to eq(true) }
    end

    context 'when #valid? true' do
      it { expect(player.valid?).to eq(true) }
    end
  end

  describe 'invalid' do
    before do
      player.instance_variable_set(:@name, empty_string)
      player.validate
    end

    context 'when #validate false' do
      it { expect(player.errors).to eq(
        [fault.player_name_length(Player::NAME_MIN_LENGTH, Player::NAME_MAX_LENGTH)]
      )}
    end

    context 'when #valid? false' do
      it { expect(player.valid?).to eq(false) }
    end
  end
end
