# frozen_string_literal: true

class Content
  class << self
    def output
      I18n.t(:output)
    end

    def input
      I18n.t(:input)
    end

    def error
      I18n.t(:error)
    end
  end
end
