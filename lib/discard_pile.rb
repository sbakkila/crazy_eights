require 'byebug'
require_relative 'card'
require_relative 'deck'

class DiscardPile

  attr_reader :deck, :pile

  def initialize(single_card)
    @pile = [single_card]

  end

  def matching_suit
    @pile.last.suit
    return top_value unless top_value == :eight
  end

  def matching_value
    top_value = @pile.last.value
  end

  def accept_card(card)
    @pile << card
  end

end
