# frozen_string_literal: true

RSpec.describe Console do
  subject(:console) { described_class.new }
  let(:output) { Output.new }
  let(:fault) { Fault.new }
  let(:statistic) { Statistic.new }

  let(:invalid_command) { 'invalid command' }

  describe '#menu' do
    it 'shows indroduction message and menu' do
      expect(output).to receive(:introduction)
      output.send(:introduction)
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

    context 'when command is invalid' do
      it do
        allow(console).to receive(:user_input).and_return(invalid_command)
        expect(fault).to receive(:unexpected_option)
        expect(output).to receive(:show)
        output.show(fault.unexpected_option)
      end
    end
  end

  describe '#navigation' do
    it 'navigates player to guess code' do
      expect(console).to receive(:registration)
      expect(console).to receive(:select_difficulty)
      expect(console).to receive(:game)
      console.registration
      console.select_difficulty
      console.game
    end
  end

  describe '#registration' do
    it 'creates instance variable @player' do
      expect(output).to receive(:registration_header)
      output.registration_header
      allow(console).to receive(:create_class).with(Player)
    end
  end

  describe '#select_difficulty' do
    it 'provides input to select difficulty' do
      expect(output).to receive(:difficulty_header)
      output.difficulty_header
      expect(Difficulty).to receive(:list).and_return(Difficulty::DIFFICULTIES.keys.map(&:to_s).map(&:capitalize))
      Difficulty.list
      allow(console).to receive(:create_class).with(Difficulty)
    end
  end
end
