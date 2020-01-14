class Validsender
  include ActiveModel::Model
  attr_accessor :sender_id, :sender_tel, :sender_add, :sender_area, :days, :w0, :w1, :w2, :w3, :w4, :w5, :w6, :readme

  validates :sender_add, presence: true
  validates :sender_tel,presence: true   

  def validsender?
    return false unless valid?
    true
  end
end
