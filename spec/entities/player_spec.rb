# frozen_string_literal: true

RSpec.describe Player do
  let(:name) { 'Andrei' }
  let(:subject) { described_class.new(name) }
  let(:invalid_name) { {short: 'An', long: 'Abcdefghijklmnopqrst'} }

  describe '.new' do
    it { expect(subject.name).to eq(name) }
  end

  describe '#validate' do
    it 'check invalid name' do
      subject.validate(invalid_name[:short])
      subject.validate(invalid_name[:long])
      expect(subject.errors).not_to be_empty
    end
  end
end
