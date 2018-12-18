# frozen_string_literal: true

RSpec.describe ValidatedEntity do
  subject(:validated_entity) { described_class.new }

  describe '.new' do
    it { expect(validated_entity.instance_variable_get(:@errors)).to eq([]) }
  end

  describe '#validate' do
    it { expect { validated_entity.validate }.to raise_error(NotImplementedError) }
  end
end
