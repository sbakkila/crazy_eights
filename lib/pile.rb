class Pile
  attr_reader :suit, :value

  def initialize(suit, value)
    raise "Cannot start pile with eight!" if value == :eight
    @suit = suit
    @value = value
  end

  def set_suit(suit)
    @suit = suit
  end

  def update_pile(card)
    raise "You cannot play that card!" if card.value != value && card.suit != suit
    @suit = card.suit
    @value = card.value
  end

end
