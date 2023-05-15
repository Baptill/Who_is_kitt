class Turn < ApplicationRecord
  belongs_to :player
  belongs_to :card, optional: true
  belongs_to :characteristic, optional: true

  def characteristic?
    characteristic.present?
  end
end
