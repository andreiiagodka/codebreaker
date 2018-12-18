# frozen_string_literal: true

RSpec.describe ConsoleMemorization do
  subject(:console_memorization) { described_class.new }

  let(:output) { Output.new }
  let(:input) { Input.new }

  let(:exit_command) { ConsoleMemorization::COMMANDS[:exit] }
  let(:invalid_exit_command) { exit_command.reverse }

  describe '#exit?' do
    context "when input is 'exit'" do
      it { expect(console_memorization.exit?(exit_command)).to eq(true) }
    end

    context "when input is not 'exit'" do
      it { expect(console_memorization.exit?(invalid_exit_command)).to eq(false) }
    end
  end

  describe '#statistic' do
    it { expect(console_memorization.instance_variable_get(:@statistic)).to be(nil) }
  end

  describe '#output' do
    it { expect(console_memorization.instance_variable_get(:@output)).to be(nil) }
  end

  describe '#input' do
    it { expect(console_memorization.instance_variable_get(:@input)).to be(nil) }
  end

  describe '#fault' do
    it { expect(console_memorization.instance_variable_get(:@fault)).to be(nil) }
  end

end
