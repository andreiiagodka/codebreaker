# frozen_string_literal: true

class Game
  attr_reader :total_attempts, :used_attempts, :total_hints, :used_hints

  def initialize(difficulty)
    @total_attempts = difficulty[:attempts]
    @used_attempts = 0
    @total_hints = difficulty[:hints]
    @used_hints = 0
  end

  def increment_used_hints
    @used_hints += 1
  end

  private

  def gameflow(secret_code)
    cloned = secret_code.clone
    loop do
      Output.statistics(self)
      input = input_secret_code
      next use_hint(cloned) if check_hint(input)

      increment_used_attempts
      marked_guess = SecretCode.mark_guess(input, secret_code)
      Output.show(marked_guess)
      return win if check_winning_combination(marked_guess)
      return loss if check_attempts
    end
  end

  def win
    Output.win
    {
      win: true,
      total_attempts: @total_attempts,
      used_attempts: @used_attempts,
      total_hints: @total_hints,
      used_hints: @used_hints
    }
  end

  def loss
    Error.attempts_limit
    {win: false}
  end

  def check_winning_combination(argument)
    argument == WINNING_COMBINATION
  end

  def check_attempts
    @used_attempts == @total_attempts
  end

  def increment_used_attempts
    @used_attempts += 1
  end
end
