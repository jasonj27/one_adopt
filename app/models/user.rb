class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :animals
  has_many :favorites
  has_many :sent_messages, :class_name => 'Message', :foreign_key => 'from_id'
  has_many :received_messages, :class_name => 'Message', :foreign_key => 'to_id'
end
