require_relative 'deck.rb'
require_relative 'player.rb'
require_relative 'pile.rb'
require 'byebug'

class Game
  attr_reader :player_count, :deck, :pile
  attr_accessor :players

  def initialize(player_count, deck = Deck.shuffled_deck)
    raise "Not enough players!" if player_count < 2
    raise "Better check yourself, fool" if player_count > 6
    @player_count = player_count
    @players = []
    @deck = deck
  end

  def deal_hands
    @players.each do |player|
      hand = deck.deal_hand(player_count)
      player.set_hand(hand)
    end
  end



end

# card = nil
# until establish deck(card)
# => card = take card
#
#
