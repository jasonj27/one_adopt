class Animal < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :reservation_pets
  has_many :favorites
  # has_many :users , through: :favorites

  enum animal_area_pkid:  {'臺北市': 2,'新北市': 3,'基隆市': 4,'宜蘭縣': 5,'桃園縣': 6,'新竹縣': 7,'新竹市': 8,'苗栗縣': 9,'臺中市': 10,'彰化縣': 11,'南投縣': 12,'雲林縣': 13,'嘉義縣': 14,'嘉義市': 15,'臺南市': 16,'高雄市': 17,'屏東縣': 18,'花蓮縣': 19,'臺東縣': 20,'澎湖縣': 21,'金門縣': 22,'連江縣': 23}
  enum animal_kind: {"貓":1, "狗":2}
  enum animal_sex: {"公":1, "母": 2, "還未輸入":3}
  enum animal_age: {"幼年":1, "成年": 2}
  enum animal_sterilization: {"是": 1, "否": 2, "未輸入": 3}
  enum animal_status: {"未公告":1, "開放認養":2, "已經認養":3, "其他":4, "死亡":5,}
  enum adopt_status: {"未上架": 1, "待領養": 2, "已領養": 3}

  # search_form_select
  ANIMAL_KIND_CLASS = [["貓咪","貓"],["狗狗","狗"],["兔子","兔"],["老鼠","鼠"]]
  ANIMAL_SEX_CLASS = [["男生","公"],["女生","母"],["未知","還未輸入"]]
  ANIMAL_AGE_CLASS = [["0~7 years old","幼年"],["> 7 years old","成年"],["未知",""]]
  ANIMAL_STERILIZATION_CLASS = [["結紮","是"],["尚未結紮","否"],["未知","未輸入"]]
  ANIMAL_AREA_PKID_CLASS = [["臺北市"],["新北市"],["基隆市"], ['宜蘭縣'], ['桃園縣'], ['新竹縣'], ['新竹市'], ['苗栗縣'], ['臺中市'], ['彰化縣'], ['南投縣'], ['雲林縣'], ['嘉義縣'], ['嘉義市'], ['臺南市'], ['高雄市'], ['屏東縣'], ['花蓮縣'], ['臺東縣'], ['澎湖縣'], ['金門縣'], ['連江縣']]

  # scope
  scope :search_kind, -> (animal_kind) { animal_kind.present? ? where(animal_kind: animal_kind) : all }
  scope :search_sex, -> (animal_sex) { animal_sex.present? ? where(animal_sex: animal_sex) : all  }
  scope :search_age, -> (animal_age) { animal_age.present? ? where(animal_age: animal_age) : all }
  scope :search_sterilization, -> (animal_sterilization) { animal_sterilization.present? ? where(animal_sterilization: animal_sterilization) : all }
  scope :search_area_pkid, -> (animal_area_pkid) { animal_area_pkid.present? ? where(animal_area_pkid: animal_area_pkid) : all }
  def favorited_by?(user)
    favorites.exists?(user: user)
  end

  def self.sex_options
    a = self.animal_sexes.map do |k,_v|
      if k == "還未輸入"
      else
        [k, _v]
      end
    end
    a.compact!
    p a
    return a
  end

end
