# frozen_string_literal: true

RSpec.describe Console do
  subject(:console) { described_class.new }
  let(:invalid) { 'invalid command' }

  describe '#start' do
    it do
      expect(console).to receive(:options)
      console.start
    end
  end

  describe '#option_cases' do
    it 'when start command' do
      allow(console).to receive(:input).and_return(START_COMMAND)
      expect(console).to receive(:gameplay)
      console.gameplay
    end

    it 'when rules command' do
      allow(console).to receive(:input).and_return(RULES_COMMAND)
      expect(console).to receive(:output)
      console.output
    end

    it 'when stats command' do
      allow(console).to receive(:input).and_return(STATS_COMMAND)
      expect(console).to receive(:statistic)
      console.statistic
    end

    it 'when exit command' do
      allow(console).to receive(:input).and_return(EXIT_COMMAND)
      expect(console).to receive(:exit_from_console)
      console.exit_from_console
    end

    it 'when invalid command' do
      allow(console).to receive(:input).and_return(invalid)
      expect(console).to receive(:fault)
      console.fault
    end
  end
end
