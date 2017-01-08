require 'rspec'
require 'game'
require 'byebug'


describe Game do
  let(:deck) { double("deck", :class => Deck, :hand => "hand") }
  subject(:game) { Game.new(5, deck) }
  let(:player_1) { double("player_1") }
  let(:player_2) { double("player_2") }
  let(:player_3) { double("player_3") }
  let(:player_4) { double("player_4") }
  let(:player_5) { double("player_5") }
  let(:players) do
    players = [
      player_1,
      player_2,
      player_3,
      player_4,
      player_5
    ]
  end
  before(:each) do
    game.players = players
  end

  describe '#initialize' do
    it 'must have at least 2 players' do
      expect { Game.new(1) }.to raise_error("Not enough players!")
    end
    it 'takes up to 6 players' do
      expect { Game.new(7) }.to raise_error("Better check yourself, fool")
    end
    it 'generates array of players' do
      expect(game.players).to be_a(Array)
    end
    it 'generates a shuffled deck' do
      expect(game.deck.class).to eq(Deck)
    end
  end

  describe '#deal_hands' do
    before(:each) do
      players.each do |player|
        allow(player).to receive(:set_hand)
      end
      allow(deck).to receive(:deal_hand)
    end

    it 'calls deck#deal_hands with player_count' do
      expect(deck).to receive(:deal_hand).exactly(5).times#.and_return
      game.deal_hands
    end
    it 'deals generated hands to each player' do
      players.each do |player|
        expect(player).to receive(:set_hand).with(any_args)
      end
      game.deal_hands
    end
  end


  describe '#establish_pile' do
    let(:pile) { double("pile", :class => Pile) }
    allow(deck).to receive(:take)
    it 'creates pile object with top card from deck' do
      expect(game.pile.class).to be(Pile)
    end
    # it 'takes a card from deck' do
    #   expect(deck).to receive(:take)
    #   game.establish_pile
    # end
    # context 'When an 8 is drawn' do
    #   let(:card) { double("card", :value => :eight )}
    #   allow(deck).to receive(:return_eight).with(any_args)
    #   allow(deck).to receive(:take).and_return(card)
    #   it 'if 8 is drawn, deck#return_eight is called' do
    #
    #     expect(deck).to receive(:return_eight)
    #
    #   end
    #   it 'takes the next card if the last flipped was an 8'
    # end
  end

  describe "#play_turn" do
    it 'asks each player for played cards'
    it 'updates pile with each card'
  end

  describe '#eight?' do
    it 'checks that card is an eight'
  end

  describe '#eight_placed' do
    it 'asks player who played eight to change suit'
    it 'reassigns current suit'
  end

  describe '#game_over?' do
    it 'checks if any player has no cards left'
  end



end
