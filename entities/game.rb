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
    generated = generate_secret_code
    puts generated
    loop do
      output_statistics
      secret_code = Input.secret_code
      check_secret_code = Validator.secret_code(secret_code)
      if check_secret_code.nil?
        result = comparison_result(secret_code, generated)
        puts result
        increment_used_attempts
        increment_used_hints if secret_code == 'hint'
        return if result == '++++'
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

  def generate_secret_code
    Array.new(4) { rand(ELEMENT_MIN_VALUE..ELEMENT_MAX_VALUE) }
  end

  def comparison_result(inputed, generated)
    digits = inputed.split('').map(&:to_i)
    gen_secret_code = generated.clone
    result = []
    digits.each_with_index do |digit, index|
      if digit == generated[index]
        result << '+'
        gen_secret_code.delete(digit)
      end
    end
    digits.each do |digit|
      result << '-' if gen_secret_code.include? digit
    end
    result.join('')
  end

  def increment_used_attempts
    @used_attempts += 1
  end

  def increment_used_hints
    @used_hints += 1
  end
end
