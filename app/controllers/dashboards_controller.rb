class DashboardsController < ApplicationController

  def show
    @user = current_user
    @ranking = compute_users_ranking
    @user_ranking = user_ranking
    @games = @user.games
    @new_game = Game.new
    @pending_game = @games.where(status: 'pending').last
    @new_id_game = Game.last.id
  end

  private

  def user_ranking
    User.select(:id, :score).order(score: :desc).each_with_index do |user, index|
    puts "Classement #{index + 1} : utilisateur #{user.id} avec un score de #{user.score}"
    end
  end
  def compute_users_ranking
    User.order(score: :desc) # { user: user, score: 89} sorted by score: :desc
  end
end
