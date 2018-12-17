# frozen_string_literal: true

RSpec.describe Console do
  subject(:console) { described_class.new }
  let(:output) { Output.new }
  let(:statistic) { Statistic.new }

  describe '#menu' do
    it 'shows indroduction message and menu' do
      expect(output).to receive(:introduction)
      output.introduction
      expect(console).to receive(:options)
      console.options
    end
  end

  describe '#options' do
    it 'shows options and require to select' do
      expect(output).to receive(:options)
      output.options
      allow(console).to receive(:select_option)
      console.select_option
    end
  end

  describe '#select_option' do
    context 'when start is chosen' do
      it do
        allow(console).to receive(:user_input).and_return(Console::COMMANDS[:start])
        expect(console).to receive(:start)
        console.start
      end
    end

    context 'when rules is chosen' do
      it do
        allow(console).to receive(:user_input).and_return(Console::COMMANDS[:rules])
        expect(output).to receive(:rules)
        output.rules
      end
    end

    context 'when stats is chosen' do
      it do
        allow(console).to receive(:user_input).and_return(Console::COMMANDS[:stats])
        expect(statistic).to receive(:rating_table)
        expect(output).to receive(:show)
        output.show(statistic.rating_table)
      end
    end
  end
end
