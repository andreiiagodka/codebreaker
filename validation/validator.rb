# frozen_string_literal: true

module Validator
  class << self
    def player_name(name)
      !name.empty? && name.length.between?(USER_NAME_MIN_SIZE, USER_NAME_MAX_SIZE)
    end

    def secret_code(secret_code)
      'Max number of digits is 4' if secret_code.size != SECRET_CODE_SIZE
    end
  end
end
