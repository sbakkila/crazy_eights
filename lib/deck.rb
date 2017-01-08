
require_relative "card.rb"
require 'byebug'

class Deck
  attr_accessor :cards

  def self.all_cards
    # debugger
    cards = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        cards << Card.new(suit, value)
      end
    end
    cards
  end

  def self.shuffled_deck
    new_deck = Deck.new
    new_deck.shuffle_deck!
    new_deck
  end

  def initialize(cards = nil)

    cards ||=  Deck.all_cards
    @cards = cards

  end

  def top_card
    cards[0]
  end

  def take
    raise "not enough cards" if @cards.empty?
    cards.shift
  end

  def count
    cards.count
  end

  def return_cards(returned_cards)
    cards.concat(returned_cards)
  end

  def shuffle_deck!
    @cards.shuffle!
  end

  def deal_hand(player_count)
    hand_size = 12 - player_count
    cards.shift(hand_size)
  end

  def deal_pile
    return_eight(top_card) while top_card.value == :eight
    val = cards.shift
    @DiscardPile = DiscardPile.new(val)
  end

  def return_eight(card)
    mid_point = count / 2
    self.cards = @cards[0...mid_point] + [card] + @cards[mid_point..-1]
  end

  def [](idx)
    @cards[idx]
  end

end
