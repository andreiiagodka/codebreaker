# frozen_string_literal: true

require 'require_all'
require 'yaml'

require_all './helpers'
require_all './entities'
require_all './validation'

require_relative './controllers/registration'
require_relative './controllers/gameplay'
require_relative './controllers/router'
require_relative './controllers/secret_code'
