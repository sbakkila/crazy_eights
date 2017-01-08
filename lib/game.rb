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
    @deck = deck
    set_players
  end

  def set_players
    possible_players = [Player.new('Kyle'), Player.new('Abs'), Player.new('Sam'),
    Player.new('Meir'), Player.new('Adam'), Player.new('Avital')]

    self.players = possible_players[0...player_count]
  end

  def deal_hands
    players.each do |player|
      initial_cards = deck.deal_hand(player_count)
      player.set_hand(initial_cards)
    end
  end

  def play_turn(player)
    #player picks cards
    #validate move
    #if 8, set the new suit
    if card.value == :eight
      puts "What suit do you want this to be?"
      deck.temporary_suit = 
    end
  end

  def play
    until won?
      players.each do |player|
        play_turn(player)
      end
    end
  end

  def won?
    players.any? { |player| player.hand.length == 0 }
  end

end


if __FILE__ == $PROGRAM_NAME
  # use print so that user input happens on the same line
  print "How many players"
  player_count = gets.chomp

  Game.new(player_count).play
end
