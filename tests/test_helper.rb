require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

require_relative 'models/board_test.rb'
require_relative 'models/card_test.rb'
require_relative 'models/graveyard_test.rb'
require_relative 'models/hand_test.rb'
require_relative 'models/player_test.rb'
require_relative 'models/stack_test.rb'
require_relative 'models/tableau_test.rb'

require_relative 'services/players_test.rb'
require_relative 'services/session_test.rb'
require_relative 'services/state_test.rb'

require_relative 'control/players_test.rb'
require_relative 'control/session_test.rb'
require_relative 'control/state_test.rb'
