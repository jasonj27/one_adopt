class Animal < ApplicationRecord
  belongs_to :user
  enum animal_area_pkid: {"基隆市": 1, "台北市": 2, "新北市": 3, "桃園縣": 4, "新竹市": 5, "新竹縣": 6, "苗栗縣": 7, "台中市": 8, "彰化縣": 9, "南投縣": 10, "雲林縣": 11, "嘉義市": 12, "嘉義縣": 13, "台南市": 14, "高雄市": 15, "屏東縣": 16, "台東縣": 17, "花蓮縣": 18, "宜蘭縣": 19, "澎湖縣": 20, "金門縣": 21, "連江縣": 22}
  enum animal_kind: {"貓":1, "狗":2}
  enum animal_sex: {"公":1, "母": 2, "未輸入":3}
  enum animal_sterilization: {"是": 1, "否": 2, "未輸入": 3}
  enum animal_status: {"未公告":1, "開放認養":2, "已認養":3, "其他":4, "死亡":5,}
  has_many_attached :images
end
