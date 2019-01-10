# frozen_string_literal: true

RSpec.describe Output do
  subject(:output_instance) { Output.new }

  let(:list_of_difficulties) { Difficulty.list.join("\n") }

  let(:difficulty) { Difficulty::DIFFICULTIES.values.sample }
  let(:game) { instance_double('Game',
    total_attempts: difficulty[:attempts],
    used_attempts: 0,
    total_hints: difficulty[:hints],
    used_hints: 0) }
  let(:statistics_message) { I18n.t('message.statistics',
    used_attempts: game.used_attempts,
    total_attempts: game.total_attempts,
    used_hints: game.used_hints,
    total_hints: game.total_hints) }

  describe '#introduction' do
    it { expect { output_instance.introduction }.to output("#{I18n.t('message.introduction')}\n").to_stdout }
  end

  describe '#rules' do
    it { expect { output_instance.rules }.to output("#{I18n.t('message.rules')}\n").to_stdout }
  end

  describe '#registration' do
    it { expect { output_instance.registration }.to output("#{I18n.t('message.registration_heading')}\n#{I18n.t('message.player_name_registration')}\n").to_stdout }
  end

  describe '#game start heading' do
    it { expect { output_instance.game_start_heading }.to output("#{I18n.t('message.game_start_heading')}\n").to_stdout }
  end

  describe '#difficulty heading' do
    it { expect { output_instance.difficulty_heading }.to output("#{I18n.t('message.difficulty_heading')}\n#{list_of_difficulties}\n").to_stdout }
  end

  describe '#win' do
    it { expect { output_instance.win }.to output("#{I18n.t('message.win')}\n").to_stdout }
  end

  describe '#exit' do
    it { expect { output_instance.exit }.to output("#{I18n.t('message.exit')}\n").to_stdout }
  end

  describe '#save result' do
    it { expect { output_instance.save_result }.to output("#{I18n.t('message.save_result')}\n").to_stdout }
  end

  describe '#start new game' do
    it { expect { output_instance.start_new_game }.to output("#{I18n.t('message.start_new_game')}\n").to_stdout }
  end

  describe '#statistics' do
    it { expect { output_instance.statistics(game) }.to output("#{statistics_message}\n#{I18n.t('message.input_secret_code')}\n").to_stdout }
  end
end
