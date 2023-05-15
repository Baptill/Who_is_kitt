class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :players
  has_one_attached :photo
  has_many :games, through: :players

  def active_player(game)
    Player.find_by(game:, user: self)
  end

  def self.scores
    User.all.map do |user|
      { "#{user.nickname}": user.score }
    end
  end
end
