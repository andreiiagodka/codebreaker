# frozen_string_literal: true

RSpec.describe ValidatedEntity do
  subject(:validated_entity) { described_class.new }

  let(:failing) { Failing.new }

  let(:empty_array) { [] }

  describe '#new' do
    it { expect(validated_entity.instance_variable_get(:@errors)).to eq(empty_array) }
  end

  describe '#validate' do
    it { expect { validated_entity.validate }.to raise_error(NotImplementedError) }
  end

  describe '#valid?' do
    it 'checks is validated entity valid' do
      expect(validated_entity).to receive(:validate)
      expect(validated_entity.instance_variable_get(:@errors)).to receive(:empty?)
      validated_entity.valid?
    end
  end

  describe '#failing' do
    it do
      validated_entity.instance_variable_set(:@failing, failing)
      expect(validated_entity.instance_variable_get(:@failing)).to be_an_instance_of(Failing)
    end
  end
end
