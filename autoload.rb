# frozen_string_literal: true

require 'require_all'
require 'yaml'

require_all './helpers'
require_all './entities'

require_relative './controllers/message'
require_relative './controllers/output'
require_relative './controllers/registration'
require_relative './controllers/game'
require_relative './controllers/router'
