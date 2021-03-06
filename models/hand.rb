require_relative 'card.rb'

module Model
  class Hand
    attr_reader :cards
    def initialize(cards)
      @cards = cards
    end

    def self.empty
      Hand.new([])
    end

    def display
      lines = @cards.map.with_index do |card, i|
        "Card #{i + 1}: #{card.display}"
      end
      lines.join("\n")
    end

    def add_cards(cards)
      Model::Hand.new(@cards + cards)
    end

    def remove_cards(first, second)
      indexes = (0..@cards.length - 1).to_a - [first - 1] - [second - 1]
      new_cards = @cards.values_at(*indexes)
      discarded_cards = @cards.values_at(first - 1, second - 1)
      [Model::Hand.new(new_cards), discarded_cards]
    end
  end
end
