class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[google_oauth2 facebook]
  has_many :animals
  has_many :favorites
  # has_many :animals , through: :favorites
  # has_many :reservations
  has_many :sent_messages, :class_name => 'Message', :foreign_key => 'from_id'
  has_many :received_messages, :class_name => 'Message', :foreign_key => 'to_id'
  has_many :sender_reservations, :class_name => 'Reservation', :foreign_key => 'sender_id'
  has_many :receiver_reservations, :class_name => 'Reservation', :foreign_key => 'receiver_id'
  # @user.sent_messages
  # @user.received_messages
  validates :name, presence: true
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
  store_accessor :available_time, :days, :w0, :w1, :w2, :w3, :w4, :w5, :w6
end
