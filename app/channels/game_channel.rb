class GameChannel < ApplicationCable::Channel
  def subscribed
    # @game = Game.find(params[:id]) # Récupère le jeu correspondant à l'ID passé en paramètre
    # p current_user # Affiche l'utilisateur actuel dans la console
    # link_invited_player unless @game.full? # Lien avec le joueur invité si le jeu n'est pas plein
    # swith_game_to_active if @game.full? && @game.status == 'pending' # Bascule le jeu en mode actif si le jeu est plein et en attente
    # stream_for @game # Diffuse les mises à jour du jeu à tous les abonnés du canal

    game = Game.find(params[:id])
    stream_for game
  end

  def unsubscribed
    # Nettoyage nécessaire lors de la désinscription du canal
  end

  private

  def link_invited_player
    @player = Player.find_by(user: current_user, game: @game) # Trouve le joueur correspondant à l'utilisateur actuel et au jeu

    @player = @game.invited_player.update(user: current_user) unless @player.present? # Si le joueur n'existe pas, met à jour le joueur invité avec l'utilisateur actuel
  end

  def swith_game_to_active
    @game.update(status: 'active') # Met à jour l'état du jeu en "actif"
    GameChannel.broadcast_to(
      @game,
      true
    ) # Diffuse les mises à jour du jeu à tous les abonnés du canal
  end

end



 # def find_or_create_game_player
  #   @player = Player.find_or_create_by(user: current_user, game: @game, score: 0)
  # end
