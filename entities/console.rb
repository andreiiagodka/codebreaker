# frozen_string_literal: true

class Console
  def start
    output.introduction
    Router.select_option
  end

  def output
    Output.new
  end
end
