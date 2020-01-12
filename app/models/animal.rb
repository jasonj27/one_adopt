class Animal < ApplicationRecord
  belongs_to :user
  has_many_attached :images
  has_many :reservation_pets
  has_many :favorites
  has_rich_text :content

  enum animal_area_pkid: {
                           '臺北市': 2, '新北市': 3, '基隆市': 4, '宜蘭縣': 5,
                           '桃園縣': 6, '新竹縣': 7, '新竹市': 8, '苗栗縣': 9,
                           '臺中市': 10, '彰化縣': 11, '南投縣': 12, '雲林縣': 13,
                           '嘉義縣': 14, '嘉義市': 15, '臺南市': 16, '高雄市': 17,
                           '屏東縣': 18, '花蓮縣': 19, '臺東縣': 20, '澎湖縣': 21,
                           '金門縣': 22, '連江縣': 23,
                         }
  enum animal_kind: { "貓貓": 1, "狗狗": 2, "兔": 3, "鼠": 4 }
  enum animal_sex: { "男生": 1, "女生": 2, "性別未知": 3 }
  enum animal_age: { "幼年": 1, "成年": 2, "年紀未知": 3 }
  enum animal_sterilization: { "已結紮": 1, "未結紮": 2, "未知": 3 }
  enum animal_status: { "未公告": 1, "開放認養": 2, "已經認養": 3, "其他": 4, "死亡": 5 }
  enum animal_bodytype: { "大型": 1, "中型": 2, "小型": 3 }
  enum animal_colour: { "三花色": 1, "白色": 2, "灰色": 3, "灰白色": 4,
                        "灰黑色": 5, "米色": 6, "咖啡色": 7, "咖啡白色": 8,
                        "咖啡棕色": 9, "咖啡黑色": 10, "花色": 11, "花白色": 12,
                        "虎斑色": 13, "虎斑白色": 14, "棕色": 15, "棕白色": 16,
                        "棕灰色": 17, "棕黑色": 18, "黃色": 19, "黃白色": 20,
                        "黃虎斑色": 21, "黑色": 22, "黑白色": 23, "黑灰色": 24,
                        "黑虎斑色": 25, "黑棕色": 26, "黑黃色": 27, "未知色": 28 }
  enum adopt_status: { "未上架": 1, "待領養": 2, "已領養": 3 }

  # search_form_select
  ANIMAL_KIND_CLASS = [["貓貓"], ["狗狗"]]
  ANIMAL_SEX_CLASS = [["男生", "男生"], ["女生", "女生"], ["性別未知", "性別未知"]]
  ANIMAL_AGE_CLASS = [["幼年"], ["成年"], ["年紀未知"]]
  ANIMAL_BODYTYPE_CLASS = [["大型"], ["中型"], ["小型"]]
  ANIMAL_COLOUR_CLASS = [["三花色"], ["白色"], ["灰色"], ["灰白色"], ["灰黑色"],
                         ["米色"], ["咖啡色"], ["咖啡白色"], ["咖啡棕色"], ["咖啡黑色"],
                         ["花色"], ["花白色"], ["虎斑色"], ["虎斑白色"], ["棕色"],
                         ["棕白色"], ["棕灰色"], ["棕黑色"], ["黃色"], ["黃白色"],
                         ["黃虎斑色"], ["黑色"], ["黑白色"], ["黑灰色"], ["黑虎斑色"],
                         ["黑棕色"], ["黑黃色"], ["未知色"]]
  ANIMAL_STERILIZATION_CLASS = [["已結紮"], ["未結紮"], ["未知"]]
  ANIMAL_AREA_PKID_CLASS = [["臺北市"], ["新北市"], ["基隆市"], ["宜蘭縣"], ["桃園縣"],
                            ["新竹縣"], ["新竹市"], ["苗栗縣"], ["臺中市"], ["彰化縣"],
                            ["南投縣"], ["雲林縣"], ["嘉義縣"], ["嘉義市"], ["臺南市"],
                            ["高雄市"], ["屏東縣"], ["花蓮縣"], ["臺東縣"], ["澎湖縣"],
                            ["金門縣"], ["連江縣"]]
  ANIMAL_SHELTER_CLASS = [["是", "收容所"], ["否", "中途之家"]]
  ADOPT_STATUS_CLASS = [["可以", "待領養"], ["不可以", "未上架"]]

  # scope
  scope :search_kind, ->(animal_kind) { animal_kind.present? ? where(animal_kind: animal_kind) : all }
  scope :search_sex, ->(animal_sex) { animal_sex.present? ? where(animal_sex: animal_sex) : all }
  scope :search_age, ->(animal_age) { animal_age.present? ? where(animal_age: animal_age) : all }
  scope :search_bodytype, ->(animal_bodytype) { animal_bodytype.present? ? where(animal_bodytype: animal_bodytype) : all }
  scope :search_colour, ->(animal_colour) { animal_colour.present? ? where(animal_colour: animal_colour) : all }
  scope :search_sterilization, ->(animal_sterilization) { animal_sterilization.present? ? where(animal_sterilization: animal_sterilization) : all }
  scope :search_area_pkid, ->(animal_area_pkid) { animal_area_pkid.present? ? where(animal_area_pkid: animal_area_pkid) : all }
  scope :search_shelter, ->(animal_shelter) {
          animal_shelter.present? ?
            if animal_shelter == "收容所"
            Animal.where(gov_shelter: true)
          elsif animal_shelter == "中途之家"
            Animal.where.not(gov_shelter: true)
          end : all
        }

  def favorited_by?(user)
    favorites.exists?(user: user)
  end

  def self.sex_options
    a = self.animal_sexes.map do |k, _v|
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
