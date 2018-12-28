# frozen_string_literal: true

require 'pry'
require 'require_all'
require 'yaml'
require 'i18n'
require 'terminal-table'

require_relative 'config/i18n'

require_relative 'lib/helpers/io_helper'
require_all 'lib/helpers'

require_relative 'lib/entities/console'
require_relative 'lib/entities/validated_entity'
require_relative 'lib/entities/player'
require_relative 'lib/entities/difficulty'
require_relative 'lib/entities/guess'
require_relative 'lib/entities/game'
require_relative 'lib/entities/statistic'
