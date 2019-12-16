class Message < ApplicationRecord
  belongs_to :from, :class_name => 'User'
  belongs_to :to, :class_name => 'User'
  # @message.from.name
  # @message.to.name
end
