# frozen_string_literal: true

module SecretCode
  class << self
    def generate
      Array.new(4) { rand(ELEMENT_MIN_VALUE..ELEMENT_MAX_VALUE) }
    end

    def mark_guess(input, generated)
      marked_guess = find_matches(input, generated)
      convert_guess(marked_guess)
    end

    private

    def find_matches(input, generated)
      cloned = generated.clone
      digits = convert_input(input)
      marked_guess = []
      exact_match(digits, marked_guess, cloned)
      number_match(digits, marked_guess, cloned)
      marked_guess
    end

    def exact_match(digits, marked_guess, cloned)
      secret_code = cloned.clone
      digits.each_with_index do |digit, index|
        next unless digit == secret_code[index]
        
        marked_guess << '+'
        remove_digit(digit, cloned)
      end
    end

    def number_match(digits, marked_guess, cloned)
      digits.each do |digit|
        next unless cloned.include? digit

        digit_quantity = cloned.count(digit)
        digit_quantity.times { marked_guess << '-' }
      end
    end

    def remove_digit(digit, cloned)
      cloned.delete_at(cloned.index(digit))
    end

    def convert_input(secret_code)
      secret_code.split('').map(&:to_i)
    end

    def convert_guess(guess)
      guess.join('')
    end
  end
end
