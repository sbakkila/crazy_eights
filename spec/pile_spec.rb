require 'rspec'
require 'pile'

describe Pile do

  subject(:pile) { Pile.new(:hearts, :ten) }

  describe '#initialize' do
    it 'sets the pile suit and value correctly' do
      expect(pile.suit).to eq(:hearts)
      expect(pile.value).to eq(:ten)
    end

    it 'does not accept eights' do
      expect { Pile.new(:hearts, :eight) }.to raise_error("Cannot start pile with eight!")
    end
  end

  describe '#set_suit' do
    it 'changes the suit' do
      expect(pile.suit).to eq(:hearts)
      pile.set_suit(:spades)
      expect(pile.suit).to eq(:spades)
    end
  end


  describe '#update_pile' do
    let(:card_1) { double("card_1", :suit => :clubs, :value => :ten)}
    let(:card_2) { double("card_2", :suit => :hearts, :value => :jack)}
    let(:card_3) { double("card_3", :suit => :spades, :value => :five)}

    it 'resets by suit' do
      expect(pile.suit).to eq(:hearts)
      expect(pile.value).to eq(:ten)
      pile.update_pile(card_1)
      expect(pile.suit).to eq(:clubs)
      expect(pile.value).to eq(:ten)
    end

    it 'resets by value' do
      expect(pile.suit).to eq(:hearts)
      expect(pile.value).to eq(:ten)
      pile.update_pile(card_2)
      expect(pile.suit).to eq(:hearts)
      expect(pile.value).to eq(:jack)
    end

    it 'checks for invalid moves' do
      expect { pile.update_pile(card_3) }.to raise_error("You cannot play that card!")
    end
  end


end
