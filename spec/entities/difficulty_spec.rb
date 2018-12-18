# frozen_string_literal: true

RSpec.describe Difficulty do
  subject(:subject) { described_class.new(valid_difficulty) }
  let(:fault) { Fault.new }

  let(:valid_difficulty) { valid_difficulties.sample.to_s }
  let(:invalid_difficulty) { valid_difficulty.reverse }

  let(:valid_difficulties) { Difficulty::DIFFICULTIES.keys }
  let(:difficulties_list) { valid_difficulties.map(&:to_s).map(&:capitalize) }

  describe '.new' do
    it 'iterates over entity cases' do
      valid_difficulties.each do |difficulty|
        entity = described_class.new(difficulty)
        expect(entity.instance_variable_get(:@difficulty)).to eq(difficulty)
        expect(entity.instance_variable_get(:@level)).to eq(Difficulty::DIFFICULTIES[difficulty])
        expect(entity.instance_variable_get(:@errors)).to eq([])
      end
    end
  end

  describe '.list' do
    it { expect(described_class.list).to eq(difficulties_list) }
  end

  describe 'valid' do
    before { subject.validate }

    context 'when #validate true' do
      it { expect(subject.errors.empty?).to eq(true) }
    end

    context 'when #valid? true' do
      it { expect(subject.valid?).to eq(true) }
    end
  end

  describe 'invalid' do
    before do
      subject.instance_variable_set(:@difficulty, invalid_difficulty)
      subject.validate
    end

    context 'when #validate false' do
      it { expect(subject.errors).to eq([fault.unexpected_difficulty]) }
    end

    context 'when #valid? false' do
      it { expect(subject.valid?).to eq(false) }
    end
  end
end
