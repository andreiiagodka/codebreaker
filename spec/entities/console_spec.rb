# frozen_string_literal: true

RSpec.describe Console do
  subject(:console) { described_class.new }

  let(:statistic) { Statistic.new }

  let(:difficulty_double) { instance_double('Difficulty', level: Difficulty::DIFFICULTIES[random_difficulty]) }
  let(:guess_double) { instance_double('Guess', guess_code: random_secret_code.join) }

  let(:list_of_options) { console.options_list.join("\n") }
  let(:invalid_command) { Console::COMMANDS.keys }
  let(:random_difficulty) { Difficulty::DIFFICULTIES.keys.sample }
  let(:random_secret_code) { Array.new(Game::SECRET_CODE_LENGTH) { rand(Game::ELEMENT_VALUE_RANGE) } }

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

    it 'when command #start' do
      allow(console).to receive(:user_input).and_return(Console::COMMANDS[:start])
      expect(console).to receive(:navigation)
      console.select_option
    end

    it 'when command #rules' do
      allow(console).to receive(:user_input).and_return(Console::COMMANDS[:rules])
      expect { console.select_option }.to output("#{I18n.t('message.rules')}\n").to_stdout
    end

    it 'when command #stats' do
      allow(console).to receive(:user_input).and_return(Console::COMMANDS[:stats])
      expect { console.select_option }.to output("#{statistic.rating_table}\n").to_stdout
    end

    it 'when command is invalid' do
      allow(console).to receive(:user_input).and_return(invalid_command)
      expect { console.select_option }.to output("#{I18n.t('error.unexpected_option')}\n").to_stdout
    end
  end

  describe '#navigation' do
    before do
      allow(console).to receive(:user_input).and_return(Console::COMMANDS[:start])
      allow(console).to receive(:game_process)
    end

    it 'calls methods which create Player and Difficulty instances' do
      expect(console).to receive(:create_entity).with(Player)
      expect(console).to receive(:create_entity).with(Difficulty)
      console.select_option
    end
  end

  describe '#game_process' do
    before do
      allow(console).to receive(:user_input).and_return(Console::COMMANDS[:start], difficulty_double.level[:level])
      allow(console).to receive(:make_guess)
      console.instance_variable_set(:@difficulty, difficulty_double)
    end

    it 'outputs game start message' do
      expect { console.send(:game_process) }.to output("#{I18n.t('message.game_start_heading')}\n").to_stdout
      console.select_option
    end

    it 'creates Game instance' do
      expect(Game).to receive(:new).with(difficulty_double.level)
      console.select_option
    end
  end

  describe '#make_guess' do
    before do
      allow(console).to receive(:user_input).and_return(Console::COMMANDS[:start], difficulty_double.level[:level])
      allow(console).to receive(:loop).and_yield
    end

    it 'outputs hint' do
      expect(console.instance_variable_get(:@guess)).to receive(:hint?).and_return(true)
      expect(console).to receive(:output_hint)
      console.select_option
    end

    it 'outputs guess result' do
      expect(console.instance_variable_get(:@guess)).to receive(:hint?)
      expect(console).to receive(:guess_result)
      console.select_option
    end
  end

  describe '#output_hint' do
    before do
      allow(console).to receive(:user_input).and_return(Console::COMMANDS[:start], difficulty_double.level[:level])
      allow(console).to receive(:loop).and_yield
      allow(console.instance_variable_get(:@guess)).to receive(:hint?)
      allow(console).to receive(:guess_result)
    end

    it 'outputs hints limit message' do
      allow(console.instance_variable_get(:@game)).to receive(:hints_available?).and_return(true)
      expect { console.send(:output_hint) }.to output("#{I18n.t('error.hints_limit')}\n").to_stdout
      console.select_option
    end

    it 'outputs hint' do
      allow(console.instance_variable_get(:@game)).to receive(:hints_available?)
      allow(console.instance_variable_get(:@game)).to receive(:use_hint)
      expect { console.send(:output_hint) }.to output("#{@game.use_hint}\n").to_stdout
      console.select_option
    end
  end
end
