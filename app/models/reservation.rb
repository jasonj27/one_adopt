class Reservation < ApplicationRecord
  belongs_to :sender, :class_name => 'User'
  belongs_to :receiver, :class_name => 'User'
  has_many :reservation_pets
  
  enum status: {"待處理": 1,"已確認": 2,"已取消": 3,"領養成功": 4,"領養失敗": 5}
end
