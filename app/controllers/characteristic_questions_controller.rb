class CharacteristicQuestionsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])
    @characteristic_question = CharacteristicQuestion.new(characteristic_id: params[:characteristic_id])
    @characteristic_question.game = @game
    @characteristic_question.player = Player.find_by(user: current_user, game: @game)

    if @characteristic_question.save
      GameChannel.broadcast_to(@game, true)
      head :ok
    else
      render "games/show", status: :unprocessable_entity
    end
  end

  def update
    @characteristic_question = CharacteristicQuestion.find(params[:id])
    @game = @characteristic_question.game
    @active_player = @characteristic_question.player
    @player_cards = @active_player.cards.where(active: true)

    @char_cards = @player_cards.select do |card|
      card.characteristics.include?(@characteristic_question.characteristic)
    end

    @not_char_cards = @player_cards.reject do |card|
      card.characteristics.include?(@characteristic_question.characteristic)
    end

    if params[:answer] == "true"
      @not_char_cards.each { |card| card.update(active: false) }
    else
      @char_cards.each { |card| card.update(active: false) }
    end

    if @characteristic_question.update(answer: params[:answer])
      Turn.create(player: current_user.active_player(@game), number: @game.turns.last.number + 1)

      GameChannel.broadcast_to(@game, true)
      head :ok
    else
      render "games/show"
    end

  end

  private

  def characteristic_question_params
    params.require(:characteristic_question).permit(:characteristic_id)
  end
end
