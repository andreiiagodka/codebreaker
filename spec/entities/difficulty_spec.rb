# frozen_string_literal: true

RSpec.describe Difficulty do
  let(:empty_array) { [] }
  let(:errors_array) { [I18n.t('error.unexpected_difficulty')] }
  let(:difficulties) { Difficulty::DIFFICULTIES }
  let(:valid_difficulties) { difficulties.keys.map(&:to_s) }
  let(:input_difficulty) { valid_difficulties.sample }

  describe '#new' do
    it do
      valid_difficulties.each do |valid_difficulty|
        difficulty_instance = described_class.new(valid_difficulty)
        expect(difficulty_instance.level).to eq(difficulties[valid_difficulty.to_sym])
        expect(difficulty_instance.instance_variable_get(:@errors)).to eq(empty_array)
      end
    end
  end

  describe 'valid difficulty' do
    it 'when #validate and #valid? are true' do
      valid_difficulties.each do |valid_difficulty|
        difficulty_instance = described_class.new(valid_difficulty)
        difficulty_instance.validate
        expect(difficulty_instance.errors.empty?).to eq(true)
        expect(difficulty_instance.valid?).to eq(true)
      end
    end
  end

  describe 'invalid difficulty' do
    it 'when #validate and #valid? are false' do
      valid_difficulties.each do |valid_difficulty|
        difficulty_instance = described_class.new(valid_difficulty.succ)
        difficulty_instance.validate
        expect(difficulty_instance.errors).to eq(errors_array)
        expect(difficulty_instance.valid?).to eq(false)
      end
    end
  end

  describe '.list' do
    it { expect(described_class.list).to eq(valid_difficulties.map(&:capitalize)) }
  end
end
