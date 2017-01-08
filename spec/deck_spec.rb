require 'rspec'
require 'deck'
require 'byebug'

describe Deck do
  describe "::all_cards" do
    subject(:all_cards) { Deck.all_cards }

    it "should generate 52 cards" do
      expect(all_cards.count).to eq(52)
    end

    it "returns all cards without duplicates" do
      expect(
        all_cards.map { |card| [card.suit, card.value] }.uniq.count
      ).to eq(all_cards.count)
    end
  end

  let(:deck) { Deck.new }

  describe "#initialize" do
    it "fills itself with 52 cards" do
      deck = Deck.new
      expect(deck.count).to eq(52)
    end
  end


  describe "#take" do
  #   # **use the front of the cards array as the top**
    it "takes a cards off the top of the deck" do
      top_card = deck.cards[0]
      expect(deck.take).to eq(top_card)
    end

    it "removes cards from deck" do
      deck.take
      deck.take
      expect(deck.count).to eq(50)
    end

    it "doesn't allow you to take more cards than are in the deck" do
      52.times do
        deck.take
      end
      expect do
        deck.take
      end.to raise_error("not enough cards")
    end
  end

  describe "#return_cards" do
    it "returns cards to deck" do
      cards = []
      5.times do
        cards << deck.take
      end
      #debugger
      expect(deck.count).to eq(47)
      deck.return_cards(cards)
      expect(deck.count).to eq(52)
    end
  end


  describe '#shuffle!' do
    it 'should shuffle the cards' do
      cards = [deck.take, deck.take, deck.take]
      deck.return_cards(cards)

      not_shuffled = (1..5).all? do
        deck.shuffle_deck!
        shuffled_cards = [deck.take, deck.take, deck.take]
        deck.return_cards(shuffled_cards)

        (0..2).all? { |i| shuffled_cards[i] == cards[i] }
      end

      expect(not_shuffled).to be(false)
    end
  end

  describe '#deal_hand' do
    # hand size varies by the number of players
    # for two players, hand size is 10
    # for three, hand size is 9
    # etc. up to 6 players
    let(:game) { double("game", :player_count => 4) }

    it 'should return a new hand' do
      player_count = game.player_count
      hand = deck.deal_hand(player_count)
      expect(hand.count).to eq(8)
    end

    it 'should take cards from the deck' do
      player_count = game.player_count
      expect do
        deck.deal_hand(player_count)
      end.to change{ deck.count }.by(-8)
    end
  end

  describe '#deal_pile' do
    let(:card_1) { double("card_1", :value => :eight) }
    let(:card_2) { double("card_2", :value => :ten) }
    let(:card_3) { double("card_3", :value => :six) }
    let(:card_4) { double("card_4", :value => :nine) }
    let(:card_5) { double("card_5", :value => :two) }
    let(:cards_1) do
      cards_1 = [ card_1, card_2, card_3, card_4, card_5 ]
    end
    let(:cards_2) do
      cards_2 = [ card_2, card_1, card_3, card_4, card_5 ]
    end
    let(:deck_1) { Deck.new(cards_1) }
    let(:deck_2) { Deck.new(cards_2) }
    it 'calls #return_eight if top_card is an eight' do
      expect(deck_1).to receive(:return_eight).with(any_args)
      deck_1.deal_pile
      expect(deck.top_card.value).to be(:six)

      expect(deck.count).to be(4)
    end
    it 'returns a non-eight card' do
      #expect(deck_2).not_to receive(:return_eight).with(any_args)
      expect(deck_2.deal_pile).to eq(card_2)
    end
  end


  describe '#return_eight(card)' do
    # if an eight is pulled to start the pile
    # it must be returned to the middle of the deck
    let(:card) { double("card", :value => :eight) }

    it 'receives a card with 8 as its value' do
      expect(card.value).to be(:eight)
      deck.return_eight(card)
    end

    it 'returns the eight to the middle of the deck' do
      4.times do
        deck.take
      end
      expect(deck.count).to be(48)
      deck.return_eight(card)
      expect(deck.count).to be(49)
      expect(deck[24].value).to be(:eight)
    end
  end


end
