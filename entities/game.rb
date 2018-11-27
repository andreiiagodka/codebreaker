# frozen_string_literal: true

class Game
  attr_reader :player, :total_attempts, :used_attempts, :total_hints, :used_hints

  def initialize(player, used_attempts = 0, used_hints = 0)
    @total_attempts = player.difficulty[:attempts]
    @used_attempts = used_attempts
    @total_hints = player.difficulty[:hints]
    @used_hints = used_hints
  end

  def start
    Output.game_start
    loop do
      output_statistics
      secret_code = Input.secret_code
      check_secret_code = Validator.secret_code(secret_code)
      if check_secret_code.nil?
        increment_used_attempts
        increment_used_hints if secret_code == 'hint'
        return if @used_attempts == @total_attempts
        return if @used_hints == @total_hints
      else
        puts check_secret_code
      end
    end
  end

  private

  def output_statistics
    puts "Used attempts: #{@used_attempts}/#{@total_attempts}. Used hints: #{@used_hints}/#{@total_hints}."
  end

  def increment_used_attempts
    @used_attempts += 1
  end

  def increment_used_hints
    @used_hints += 1
  end
end
