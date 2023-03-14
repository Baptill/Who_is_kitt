class GamesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :show ]
  before_action :set_game, only: [:invite, :shifoumi, :save_winner, :save_character, :show]

  def game
    @new_game = Game.new
  end

  def select_character
    @game = Game.find(params[:game])
    @card = Card.find(params[:id])

    @card.update(guess: true)

    @game.started! if @game.players.first.cards.find_by(guess: true) && @game.players.last.cards.find_by(guess: true)
    redirect_to game_path(@game)
  end

  def move
    @end = false
    @game = Game.find(params[:game])
    # initialisation des tours de jeu à 0
    @turn = 0
    # initialisation du joueur qui commence
    @player_one = @game.players.first
    # initialisation du joueur qui répond
    @player_two = @game.players.last
    # le joueur qui commence pose une question
    @question = CharacteristicQuestion.new
    # on récupère toutes les caractéristiques
    @characteristics = Characteristic.all
    # on récupère toutes les cartes du joueur qui commence
    @player_one_cards = @player_one.cards
    # on récupère toutes les cartes du joueur qui répond
    @player_two_cards = @player_two.cards
    # on récupère toutes les cartes actives du joueur qui commence
    @player_active_cards = @player_one_cards.select { |card| card.active }
    # on récupère toutes les cartes actives du joueur qui répond
    @player_two_active_cards = @player_two_cards.select { |card| card.active }
    # on récupère toutes les cartes du joueur qui commence qui sont des guess
    @player_guess_card = @player_one_cards.find_by(guess: true)
  end


  def show
    # raise
    @game = Game.includes(players: { cards: { character: { features: :characteristic, photo_attachment: :blob}}}).find(params[:id])

    Player.find_or_create_by(user_id: current_user.id, game: @game) do |player|
      player.user = current_user
      player.game = @game
      player.score = 0
      player.winner = false
    end

    @characteristic_question = CharacteristicQuestion.new
    @characteristic_collection = Characteristic.all

    @player_one = @game.players.first
    @player_two = @game.players.last

    @current_player = current_user.active_player(@game)

    @player_one_cards = @player_one.cards
    @player_one_active_cards = @player_one_cards.select(&:active)
    @player_one_guess_card = @player_one_cards.find_by(guess: true)

    @player_two = @game.players.last
    @player_two_cards = @player_two.cards
    @player_two_active_cards = @player_two_cards.select { |card| card.active }
    @player_two_guess_card = @player_two_cards.find_by(guess: true)

    @game.active! if @game.players.count > 1 && @game.pending?

    puts "#########################"
    puts "Creating turn"
    p @game.turns.find_by(number: 1)

    Turn.create!(player: @game.players.sample, number: 1) unless @game.turns.find_by(number: 1)

    @turn = @game.turns.order(number: :asc).last
    puts "#########################"

    @characteristics = Characteristic.all
  end

  def buzz
    @game = Game.find(params[:id])
    @player = Player.find(params[:id])
    @player_cards = @player.cards.select { |card| card.active }
    @current_player = current_user.active_player(@game)
  end

  def save_winner
    @game = Game.find(params[:id])
    @card = Card.find(params[:card_id])
    @player_one = @game.players.first
    @player = @current_player
    @player_two = @game.players.last
    @player_two_guess_card = @player_two.cards.find_by(guess: true)

    if current_user == @player_one.user
      if @card == @player_two.cards.find_by(guess: true)
        @player_one.update(winner: true)
        @player_two.update(winner: false)
        @game.update(status: 'finished')
      else
        @player_one.update(winner: false)
        @player_two.update(winner: true)
        @game.update(status: 'finished')
      end
    end

    if current_user == @player_two.user
      if @card == @player_one.cards.find_by(guess: true)
        @player_one.update(winner: true)
        @player_two.update(winner: false)
        @game.update(status: 'finished')
      else
        @player_one.update(winner: false)
        @player_two.update(winner: true)
        @game.update(status: 'finished')
      end
    end

    redirect_to game_path(@game)
  end

  def create
    game = Game.new(status: 'pending')

    if game.save
      Player.create(user: current_user, game:, score: 0)
      redirect_to dashboard_path
    end
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end
end
