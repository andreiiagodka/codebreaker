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
    Output.game_start_header
    generated = SecretCode.generate
    puts generated
    gameflow(generated)
  end

  private

  def gameflow(secret_code)
    cloned = secret_code.clone
    loop do
      Output.statistics(self)
      input = Input.secret_code
      validated = Validator.secret_code(input)
      if input == HINT_KEYWORD
        show_hint(cloned)
      elsif validated.nil?
        marked_guess = SecretCode.mark_guess(input, secret_code)
        increment_used_attempts
        puts marked_guess
      else
        puts validated
      end
      return if marked_guess == WINNING_COMBINATION || check_attempts
    end
  end

  def show_hint(cloned)
    return Error.hints_limit if check_hints
    increment_used_hints
    puts cloned.shift
  end

  def check_attempts
    @used_attempts == @total_attempts
  end

  def check_hints
    @used_hints >= @total_hints
  end

  def increment_used_attempts
    @used_attempts += 1
  end

  def increment_used_hints
    @used_hints += 1
  end
end
