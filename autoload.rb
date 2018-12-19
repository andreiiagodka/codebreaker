# frozen_string_literal: true

require 'require_all'
require 'yaml'
require 'i18n'
require 'terminal-table'

require_relative 'i18n_config'

require_all './lib/helpers'

require_relative './lib/entities/console_memorization'
require_relative './lib/entities/console'
require_relative './lib/entities/validated_entity'
require_relative './lib/entities/player'
require_relative './lib/entities/difficulty'
require_relative './lib/entities/guess'
require_relative './lib/entities/game'
require_relative './lib/entities/statistic'
