# frozen_string_literal: true

RSpec.describe Game do
  let(:difficulty) { EASY_DIFFICULTY }
  let(:subject) { described_class.new(difficulty) }
  let(:input_code) { '1234' }
  let(:wrong_input_code) { {letters: 'abcd', length: '12345', digits: '7777'} }

  describe '.new' do
    it { expect(subject.difficulty).to eq(difficulty[:difficulty]) }
    it { expect(subject.total_attempts).to eq(difficulty[:attempts]) }
    it { expect(subject.total_hints).to eq(difficulty[:hints]) }
  end

  describe '#validate_secret_code' do
    it 'check input code for letters' do
      subject.validate_secret_code(wrong_input_code[:letters])
      subject.validate_secret_code(wrong_input_code[:length])
      subject.validate_secret_code(wrong_input_code[:digits])
      expect(subject.errors).not_to be_empty
    end
  end

  describe '#use_hint' do
    context 'check used hints incrementing' do
      it { expect {subject.use_hint}.to change {subject.used_hints}.by(1) }
    end
  end

  describe '#mark_guess' do
    context 'check used attempts incrementing' do
      it { expect {subject.mark_guess(input_code, subject.secret_code)}.to change {subject.used_attempts}.by(1) }
    end
  end
end
