require 'rspec'
require 'card'

describe Card do
  subject(:card) { Card.new(:spades, :ten) }
  let(:same_suit_card) { Card.new(:spades, :five)}
  let(:same_value_card) { Card.new(:hearts, :ten)}
  let(:non_matching_card) { Card.new(:hearts, :four)}

  describe '#initialize' do

    it 'sets up a card correctly' do
      expect(card.suit).to eq(:spades)
      expect(card.value).to eq(:ten)
    end
  end

  describe '#to_s' do
    it 'prints out the value and suit' do
      expect(card.to_s).to eq("10♠")
    end
  end

  describe '#matching(other_card)' do
    it 'returns truthy value if card and other card have same suit or value' do
      expect(card.matching(same_suit_card)).to be_truthy
      expect(card.matching(same_value_card)).to be_truthy
      expect(card.matching(non_matching_card)).to be_falsey
    end
  end

end
