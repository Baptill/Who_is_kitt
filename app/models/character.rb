class Character < ApplicationRecord
  has_many :cards
  has_many :features
  has_many :characteristics, through: :features
  has_one_attached :photo
end
