# frozen_string_literal: true

RSpec.describe Console do
  subject(:console) { described_class.new }

  let(:output) { Output.new }
  let(:display) { output.display }
  let(:introduction) { output.introduction }

  let(:list_of_options) { Console::COMMANDS.values.map(&:capitalize) }

  describe '#menu' do
    it 'displays introduction message' do
      allow(console).to receive(:introduction)
    end

    it 'displays options list' do
      expect(console.options_list).to eq(list_of_options)
      allow(console).to receive(:display).with(console.options_list)
    end

    it 'calls method to select option' do
      allow(console).to receive(:select_option)
    end
  end
end
