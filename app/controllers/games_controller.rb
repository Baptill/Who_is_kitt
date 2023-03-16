class GamesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :show ]
  before_action :set_game, only: [:invite, :shifoumi, :save_winner, :save_character, :show]

  def select_character
    @game = Game.find(params[:game])
    @card = Card.find(params[:id])

    @card.update(guess: true)

    @game.started! if @game.player_one.cards.find_by(guess: true) && @game.player_two.cards.find_by(guess: true)
    GameChannel.broadcast_to(@game, true)
    head :ok
  end

  def move
    @end = false
    @game = Game.find(params[:game])
    # initialisation des tours de jeu à 0
    @turn = 0
    # initialisation du joueur qui commence

    @player_one = @game.player_one
    # initialisation du joueur qui répond
    @player_two = @game.player_two
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
    @player_guess_card_two = @player_two_cards.find_by(guess: true)
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

    @player_one = @game.player_one

    @current_player = current_user.active_player(@game)

    @player_one_cards = @player_one.cards
    @player_one_active_cards = @player_one_cards.select(&:active)
    @player_one_guess_card = @player_one_cards.find_by(guess: true)

    if @game.players.count > 1
    @player_two = @game.player_two
    @player_two_cards = @player_two.cards
    @player_two_active_cards = @player_two_cards.select { |card| card.active }
    @player_two_guess_card = @player_two_cards.find_by(guess: true)

    @player_two_select_card = @player_two_cards.find_by(select: true)
    @player_one_select_card = @player_one_cards.find_by(select: true)



    @game.active! if @game.players.count > 1 && @game.pending?

    puts "#########################"
    puts "Creating turn"
    p @game.turns.find_by(number: 1)

    Turn.create!(player: @player_one, number: 1) unless @game.turns.find_by(number: 1)

    @turn = @game.turns.order(number: :asc).last
    puts "#########################"

    @characteristics = Characteristic.all
    end
  end

  def buzz
    @game = Game.find(params[:id])
    @player = Player.find(params[:id])
    @player_cards = @player.cards.select { |card| card.active }
    @game.buzzer!
    @current_player = current_user.active_player(@game)

    GameChannel.broadcast_to(@game, true)
    head :ok
  end

  def save_winner

    @current_player = current_user.active_player(@game)

    @player_one = @game.player_one
    @player_two = @game.player_two
    @game = Game.find(params[:id])
    @card = Card.find(params[:card_id])

    @player_one_guess_card = @player_one.cards.find_by(guess: true)
    @player_two_guess_card = @player_two.cards.find_by(guess: true)
    @player_one_cards = @player_one.cards

    # sur la page _buzz.html.erb récupérer la valeur de la carte séléctionnée par le joueur qui a buzzé
    # et la comparer à la valeur de la carte du joueur qui a buzzé
    # si la valeur est la même alors le joueur qui a buzzé gagne
    # sinon le joueur qui a buzzé perd
    # si le joueur qui a buzzé gagne alors on ajoute 1 point au score du joueur qui a buzzé
    # sinon on ajoute 100 points au score du joueur qui a buzzé

    if @current_player == @player_one
      if @card.character_id == @player_two_guess_card.character_id
        @player_one.update(winner: true)
        @player_two.update(winner: false)
      else
        @player_one.update(winner: false)
        @player_two.update(winner: true)
      end
      @game.update(status: 'finished')
      @game.manage_score!
    elsif @current_player == @player_two
      if @card.character_id == @player_one_guess_card.character_id
        @player_one.update(winner: false)
        @player_two.update(winner: true)
      else
        @player_one.update(winner: true)
        @player_two.update(winner: false)
      end
      @game.update(status: 'finished')
      @game.manage_score!
    end



    GameChannel.broadcast_to(@game, true)
    head :ok
    # render :show, locals: { card: @card }
  end

  def create
    @game = Game.new(status: 'pending', creator: current_user.id)

    if @game.save
      Player.create(user: current_user, game: @game, score: 0, )
      redirect_to game_path(@game)
    end
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end
end
