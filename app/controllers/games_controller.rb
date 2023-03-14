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

    # si les deux joueurs ont choisi leur personnage
    # alors on redirige vers la partial started_game
    @game.started! if @game.players.first.cards.find_by(guess: true) && @game.players.last.cards.find_by(guess: true)

    redirect_to game_path(@game)
  end

  # la méthode move gère le gameplay réel
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

  # créer une méthode permettant de buzzer pour trouver sa card guess
  # le buzz n'apparaît qu'à partir du second tour
  # si le joueur qui a buzzé a trouvé sa card guess alors il gagne la partie
  # sinon c'est l'autre joueur qui gagne la partie
  def buzz
    # Trouver la partie
    # Trouver mes cards actives
    # Les afficher sur la page buzz
    @game = Game.find(params[:id])
    @player = Player.find(params[:id])
    @player_cards = @player.cards.select { |card| card.active }

    redirect_to game_path(@game)
  end

  def save_winner
    # Trouver la card guess de l'adversaire
    # Vérifier que la card passée en params est bien la card guess de l'adversaire
    # Si c'est le cas, alors le joueur qui a buzzé gagne la partie
    # Sinon, l'autre joueur gagne la partie
    # Updater le status des players => winner true ou false
    # Changer le status de la partie
    # Rediriger vers la show de la partie
    @game = Game.find(params[:id])
    @card = Card.find(params[:card_id])
    @player = Player.find(params[:id])
    @player_two = Player.find(params[:id])
    @player_two_guess_card = @player_two.cards.find_by(guess: true)

    if @card == @player.cards.find_by(guess: true)
      @player.update(winner: true)
      @player_two.update(winner: false)
      @game.update(status: 'finished')
    else
      @player.update(winner: false)
      @player_two.update(winner: true)
      @game.update(status: 'finished')
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

# DEROULEMENT D'UNE GAME

# les deux sont sur la started game
# par défault c'est le joueur qui a créé la partie qui commence
# le joueur 1 pose sa question dans le chat (en cliquant sur l'attribut correspondant)
# le joueur 2 répond oui/non dans le chat
# en fonction de la réponse du joueur 2, les cartes conçernées se désactivent sur le plateau du joueur 1
# c'est au joueur 2 de poser sa question
# au début du 3eme tour les joueurs peuvent buzzer pour trouver leur personnage
# un des joueurs buzz
# sa réponse est bonne, il gagne la partie, on lui ajoute des points
# sa réponse est fausse, il perd la partie
