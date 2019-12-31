class Reservation < ApplicationRecord
  include AASM

  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  has_many :reservation_pets

  enum status: {pending: 1, confirmed: 2, canceled: 3, adopt_success: 4, adopt_fail: 5}

  aasm column: :status, no_direct_assignment: true, enum: true do
    state :pending, initial: true
    state :confirmed, :canceled, :adopt_success, :adopt_fail

    event :confirm_reservation do
      transitions from: :pending, to: :confirmed
    end

    event :cancel_reservation do
      transitions form: [:pending, :confirmed], to: :canceled
    end

    event :adopt do
      transitions from: :confirmed, to: :adopt_success
    end

    event :adopt_canceled do
      transitions from: :confirmed, to: :adopt_fail
    end
  end


end
