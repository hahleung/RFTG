require 'yaml'
require_relative 'stack.rb'
require_relative 'player.rb'
require_relative 'hand.rb'
require_relative 'graveyard.rb'
require_relative 'tableau.rb'
require_relative 'card.rb'

module Model
  INITIAL_NUMBER_CARDS = 6
  CARDS = YAML.load(File.read(File.join(File.expand_path(File.dirname(__FILE__)),"cards.yml")))

  class Board
    attr_reader :players, :stack, :graveyard
    def initialize(players, stack, graveyard)
      @players = players
      @stack = stack
      @graveyard = graveyard
    end

    def self.initialize_game(players_names)
      names_capitalized = players_names.map{ |name| name.capitalize }
      graveyard = Model::Graveyard.empty
      hand = Model::Hand.empty
      tableau = Model::Hand.empty
      players, stack = names_capitalized.reduce([[], Model::Stack.from_cards(CARDS)]) do |ac, it|
        new_player, new_stack = Model::Player.new(it, hand, tableau).draw(INITIAL_NUMBER_CARDS, ac.last)
        [ac.first + [new_player], new_stack]
      end
      Board.new(players, stack, graveyard)
    end

    def count_players_havent_discard
      hands_size = @players.map{ |player| player.hand.cards.length }
      hands_size.count(INITIAL_NUMBER_CARDS)
    end

    def next_player_to_discard
      hands_size = @players.map{ |player| player.hand.cards.length }
      player_index = hands_size.index(INITIAL_NUMBER_CARDS)
      @players[player_index]
    end

    def make_player_discard(first_card, second_card)
      player = self.next_player_to_discard
      new_player, new_graveyard = player.choose_first_cards(@graveyard, first_card, second_card)
      index_player = @players.index(player)
      new_players = @players.map.with_index{ |x, i| i == index_player ? new_player : x }
      [Board.new(new_players, @stack, new_graveyard), index_player]
    end
  end
end
