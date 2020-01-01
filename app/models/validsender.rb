class Validsender
  include ActiveModel::Model
  attr_accessor :sender_id, :sender_tel, :sender_add, :days, :w0, :w1, :w2, :w3, :w4, :w5, :w6

  validates :sender_add, presence: true
  validates :sender_tel, presence: true  #/^09[0-9]{8}$/

  def va?
    return false unless valid?
    true
  end
end
