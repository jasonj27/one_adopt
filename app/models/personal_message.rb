class PersonalMessage < ApplicationRecord
  include ActionView::Helpers::TextHelper
  belongs_to :conversation
  belongs_to :user
  has_rich_text :message_body

  # validates :body, presence: true
  
end
