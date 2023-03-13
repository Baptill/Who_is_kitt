class Card < ApplicationRecord
  belongs_to :character
  has_many :characteristics, through: :character
  belongs_to :player

  validates :character, presence: true
  validates :player, presence: true

  def characteristics
    # card = Card.includes(character: { features: [:characteristic] }).find(self.id)
    self.character.features.map(&:characteristic)
  end
end
