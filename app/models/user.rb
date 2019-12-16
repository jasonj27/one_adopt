class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :animals
  has_many :favorites
  has_many :reservations
  has_many :sent_messages, :class_name => 'Message', :foreign_key => 'from_id'
  has_many :received_messages, :class_name => 'Message', :foreign_key => 'to_id'
  has_many :sender_reservations, :class_name => 'Reservation', :foreign_key => 'sender_id'
  has_many :receiver_messages, :class_name => 'Reservation', :foreign_key => 'receiver_id'
  # @user.sent_messages
  # @user.received_messages
end
