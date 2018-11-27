# frozen_string_literal: true

YML_FORMAT = '.yml'

PHRASES_YML = 'phrases' + YML_FORMAT
ERRORS_YML = 'errors' + YML_FORMAT

USER_NAME_MIN_SIZE = 3
USER_NAME_MAX_SIZE = 20

EASY_DIFFICULTY = [difficulty: 'easy', attempts: 15, hints: 3].freeze
MEDIUM_DIFFICULTY = [difficulty: 'medium', attempts: 10, hints: 2].freeze
HARD_DIFFICULTY = [difficulty: 'hard', attempts: 5, hints: 1].freeze

SECRET_CODE_SIZE = 4
