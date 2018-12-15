# frozen_string_literal: true

require 'require_all'
require 'yaml'
require 'i18n'
require 'terminal-table'

require_all './lib/helpers'
require_all './lib/constants'
require_all './lib/validation'

require_relative './lib/entities/console'
require_relative './lib/entities/validated_entity'
require_relative './lib/entities/guess'
require_relative './lib/entities/player'
require_relative './lib/entities/game'
require_relative './lib/entities/statistic'

require_relative 'i18n_config'
