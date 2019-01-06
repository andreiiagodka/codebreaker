# frozen_string_literal: true

RSpec.describe Console do
  subject(:console) { described_class.new }

  let(:statistic) { Statistic.new }

  let(:list_of_options) { console.options_list.join("\n") }
  let(:invalid_command) { Console::COMMANDS.keys }

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
end
