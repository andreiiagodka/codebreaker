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
      input = input_secret_code
      if check_hint(input)
        increment_used_hints
        show_hint(cloned)
      else
        increment_used_attempts
        marked_guess = SecretCode.mark_guess(input, secret_code)
        puts marked_guess
      end
      return Output.win if check_winning_combination(marked_guess)
      return Error.attempts_limit if check_attempts
    end
  end

  def input_secret_code
    loop do
      input = Input.secret_code
      validated = Validator.secret_code(input)
      return input if check_hint(input) || validated.nil?

      puts validated
    end
  end

  def show_hint(cloned)
    return Error.hints_limit if check_hints
    
    puts cloned.shift
  end

  def check_hint(argument)
    argument == HINT_KEYWORD
  end

  def check_winning_combination(argument)
    argument == WINNING_COMBINATION
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
