# frozen_string_literal: true

RSpec.describe Guess do
  subject(:guess) { described_class.new(valid_guess_code) }

  let(:valid_guess_code) { '1234' }
  let(:invalid_guess_code) { '' }

  describe '.new' do
    it { expect(guess.guess_code).to eq(valid_guess_code)  }
  end

  describe 'valid' do
    before { guess.validate }

    context 'when #validate true' do
      it { expect(guess.errors.empty?).to eq(true) }
    end

    context 'when #valid? true' do
      it { expect(guess.valid?).to eq(true) }
    end
  end
end
