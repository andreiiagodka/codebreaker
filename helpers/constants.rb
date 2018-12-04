# frozen_string_literal: true

YML_FORMAT = '.yml'

CONTENT_YML = 'content' + YML_FORMAT

USER_NAME_MIN_LENGTH = 3
USER_NAME_MAX_LENGTH = 20

EASY_DIFFICULTY = [difficulty: 'easy', attempts: 15, hints: 3].freeze
MEDIUM_DIFFICULTY = [difficulty: 'medium', attempts: 10, hints: 2].freeze
HARD_DIFFICULTY = [difficulty: 'hard', attempts: 5, hints: 1].freeze

SECRET_CODE_LENGTH = 4

ELEMENT_MIN_VALUE = 1
ELEMENT_MAX_VALUE = 6

START_KEYWORD = 'start'
RULES_KEYWORD = 'rules'
STATS_KEYWORD = 'stats'
EXIT_KEYWORD = 'exit'
HINT_KEYWORD = 'hint'

WINNING_COMBINATION = '++++'
