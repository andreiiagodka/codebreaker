# frozen_string_literal: true
require 'pry'
RSpec.describe Console do
  subject(:console) { described_class.new }

  let(:statistic) { Statistic.new }

  let(:difficulty_double) { instance_double('Difficulty', level: Difficulty::DIFFICULTIES[random_difficulty]) }

  let(:list_of_options) { console.options_list.join("\n") }
  let(:invalid_command) { Console::COMMANDS.keys }
  let(:random_difficulty) { Difficulty::DIFFICULTIES.keys.sample }

  describe '#menu' do
    before do
      allow(console).to receive(:select_option)
      allow(console).to receive(:loop).and_yield
    end

    it 'outputs introduction message and list of options' do
      expect { console.menu }.to output("#{I18n.t('message.introduction')}\n#{list_of_options}\n").to_stdout
    end
  end

  describe '#select_option' do
    before { allow(console).to receive(:navigation) }

    after { console.send(:navigation) }

    it 'when command #start' do
      allow(console).to receive(:user_input).and_return(Console::COMMANDS[:start])
      expect(console).to receive(:navigation)
    end

    it 'when command #rules' do
      allow(console).to receive(:user_input).and_return(Console::COMMANDS[:rules])
      expect { console.send(:select_option) }.to output("#{I18n.t('message.rules')}\n").to_stdout
    end

    it 'when command #stats' do
      allow(console).to receive(:user_input).and_return(Console::COMMANDS[:stats])
      expect { console.send(:select_option) }.to output("#{statistic.rating_table}\n").to_stdout
    end

    it 'when command is invalid' do
      allow(console).to receive(:user_input).and_return(invalid_command)
      expect { console.send(:select_option) }.to output("#{I18n.t('error.unexpected_option')}\n").to_stdout
    end
  end

  describe '#navigation' do
    before { allow(console).to receive(:game_process) }

    after { console.send(:navigation) }

    it 'calls create Player and Difficulty instances methods' do
      allow(console).to receive(:user_input).and_return(Console::COMMANDS[:start])
      expect(console).to receive(:create_entity).with(Player)
      expect(console).to receive(:create_entity).with(Difficulty)
    end
  end

  describe '#game_process' do
    before { allow(console).to receive(:make_guess) }

    after { console.send(:game_process) }

    it 'creates Game instance' do
      console.instance_variable_set(:@difficulty, difficulty_double)
      expect { console.send(:game_process) }.to output("#{I18n.t('message.game_start_heading')}\n").to_stdout
      expect(Game).to receive(:new).with(difficulty_double.level)
    end
  end

  describe '#make_guess' do
    before do
      allow(console).to receive(:loop).and_yield
      expect(console).to receive(:create_entity).with(Guess)
    end

    after { console.send(:make_guess) }

    it 'calls #output_hint' do
      allow(console.instance_variable_get(:@guess)).to receive(:hint?).and_return(true)
      expect(console).to receive(:output_hint)
    end

    it 'calls #guess_result' do
      allow(console.instance_variable_get(:@guess)).to receive(:hint?).and_return(false)
      expect(console).to receive(:guess_result)
    end
  end

  describe '#output_hint' do
    
  end
end
