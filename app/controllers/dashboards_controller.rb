class DashboardsController < ApplicationController

  def show
    @user = current_user
    @ranking = compute_users_ranking
    @user_ranking = user_ranking
    @games = @user.games
    @new_game = Game.new
    @pending_game = @games.where(status: 'pending').last
    @new_id_game = Game.last.id
    @users = User.all
    @top10 = @users.order(score: :desc).limit(10)
    @top10batch = @users.where(batch: current_user.batch).order(score: :desc).limit(10)
  end

  private

  def user_ranking
   User.scores
  end

  def compute_users_ranking
    User.order(score: :desc)
  end
end
