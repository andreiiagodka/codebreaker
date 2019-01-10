# frozen_string_literal: true

RSpec.describe ConsoleUserInteraction do
  subject(:console) { Console.new }

  let(:list_of_options) { Console::COMMANDS.values.map(&:capitalize) }

  describe '#options_list' do
    it { expect(console.options_list).to eq list_of_options }
  end

  describe '#user_input' do
    after { console.user_input }

    it 'gets user input' do
      expect(console).to receive_message_chain(:gets, :chomp, :downcase)
    end

    it 'when exit' do
      allow(console).to receive_message_chain(:gets, :chomp, :downcase).and_return(Console::COMMANDS[:exit])
      expect(console).to receive(:exit_from_console)
    end
  end

  describe '#exit from console' do
    it { expect { console.exit_from_console }.to output("#{I18n.t('message.exit')}\n").to_stdout }
    it { expect { console.exit_from_console }.to raise_error(SystemExit) }
  end
end
