# frozen_string_literal: true

class Fault
  def initialize
    @fault = I18n.t(:fault)
  end

  def get(argument, fault = @fault)
    fault[argument]
  end

  def unexpected_command
    puts get(:unexpected_command)
  end
end
