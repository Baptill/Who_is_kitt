class Game < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :turns, through: :players
  has_many :users, through: :players
  has_many :characteristic_questions, dependent: :destroy

  # after_commit :broadcast_data

  def full?
    players.where.not(user: nil).count == 2 # Vérifie si le jeu est plein (c'est-à-dire si deux joueurs sont associés à ce jeu)
  end

  def invited_player
    players.where(user: nil).first # Retourne le joueur invité pour le jeu (le joueur qui n'a pas encore rejoint le jeu)
  end

  def user_two
    players.last.user
  end

  def user_one
    players.first.user
  end

  def player_one_active_cards
    players.first.cards.where(active: true)
  end

  def player_two_active_cards
    players.last.cards.where(active: true)
  end

  def pending!
    update(status: "pending")
  end

  def pending?
    status == "pending"
  end

  def active!
    update(status: "active")
  end

  def active?
    status == "active"
  end

  def started!
    update(status: "started")
  end

  def started?
    status == "started"
  end

  def finished!
    update(status: "finished")
  end

  def finished?
    status == "finished"
  end

  def buzzer!
    update(status: "buzzer")
  end

  def buzzer?
    status == "buzzer"
  end

  private

  def broadcast_data
    show_data = GamesController.renderer.render(partial: 'games/game', locals: { game: self }) # Rend la partial 'games/game' avec les données du jeu actuel
    game_data = { game: self, show_data: show_data } # Crée un hash avec les données du jeu et la partial rendue
    ActionCable.server.broadcast("GameChannel", game_data) # Diffuse les mises à jour du jeu à tous les abonnés du canal "GameChannel"
  end
end
