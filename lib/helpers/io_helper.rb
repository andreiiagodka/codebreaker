# frozen_string_literal: true

class IOHelper
  def get(section, message, *parameters)
    I18n.t(translation_access(section, message), *parameters)
  end

  def output(argument)
    puts argument
  end

  private

  def translation_access(section, message)
    "#{section}.#{convert_to_string(message)}"
  end

  def convert_to_string(argument)
    argument.to_s
  end
end
