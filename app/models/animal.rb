class Animal < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :reservation_pets

  enum animal_area_pkid:  {'臺北市': 2,'新北市': 3,'基隆市': 4,'宜蘭縣': 5,'桃園縣': 6,'新竹縣': 7,'新竹市': 8,'苗栗縣': 9,'臺中市': 10,'彰化縣': 11,'南投縣': 12,'雲林縣': 13,'嘉義縣': 14,'嘉義市': 15,'臺南市': 16,'高雄市': 17,'屏東縣': 18,'花蓮縣': 19,'臺東縣': 20,'澎湖縣': 21,'金門縣': 22,'連江縣': 23}
  enum animal_kind: {"貓":1, "狗":2}
  enum animal_sex: {"公":1, "母": 2, "還未輸入":3}
  enum animal_age: {"幼年":1, "成年": 2}
  enum animal_sterilization: {"是": 1, "否": 2, "未輸入": 3}
  enum animal_status: {"未公告":1, "開放認養":2, "已經認養":3, "其他":4, "死亡":5,}
  enum adopt_status: {"未上架": 1, "待領養": 2, "已領養": 3}
end
