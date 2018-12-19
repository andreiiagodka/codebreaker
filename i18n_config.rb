# frozen_string_literal: true

DB_DIR = 'database'
CONTENT_FILE = 'content'
YML_FORMAT = '.yml'

I18n.load_path << Dir[File.expand_path(DB_DIR) + '/' + CONTENT_FILE + YML_FORMAT]
