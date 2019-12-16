class ReservationPet < ApplicationRecord
  belongs_to :animal
  belongs_to :reservation
end
