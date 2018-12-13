# frozen_string_literal: true

RSpec.describe Game do
  let(:difficulty) { EASY_DIFFICULTY }
  let(:subject) { described_class.new(difficulty) }
  let(:input_code) { '1234' }

  describe '.new' do
    it { expect(subject.difficulty).to eq(difficulty[:difficulty]) }
    it { expect(subject.total_attempts).to eq(difficulty[:attempts]) }
    it { expect(subject.total_hints).to eq(difficulty[:hints]) }
  endgst

  describe '#hint' do
    context 'check used hints incrementing' do
      it { expect {subject.hint}.to change {subject.used_hints}.by(1) }
    end
  end

  describe '#mark_guess' do
    context 'check used attempts incrementing' do
      it { expect {subject.mark_guess(input_code, subject.secret_code)}.to change {subject.used_attempts}.by(1) }
    end
  end
end
