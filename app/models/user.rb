class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :players
  has_one_attached :photo
  has_many :games, through: :players

  def active_player(game)
    Player.find_by(game:, user: self)
  end
end
