# frozen_string_literal: true

RSpec.describe Player do
  let(:name) { 'Andrei' }
  let(:subject) { described_class.new(name) }
  let(:invalid_name) { {short: 'An', long: 'Abcdefghijklmnopqrst'} }

  describe '.new' do
    it { expect(subject.name).to eq(name) }
  end
end
