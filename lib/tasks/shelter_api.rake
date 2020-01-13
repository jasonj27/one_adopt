require 'json'
require 'open-uri'
require 'net/http'

namespace :access do
  desc "Grab Animals data and Parse Json, if no enter quantity then grab 20"
  task :shelter_api, [:quantity] => [:environment]  do |task, args|
    
    # 抓取收容所API
    url = 'https://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    @result = JSON.parse(response)

    # 找出已建立的收容所user 
    shelter = User.where("email ILIKE :email", email: "%pet.com").map{  |x| { x.name => x.id } }.inject(:merge)

    # 若為輸入數量預設抓20隻
    args.with_defaults(quantity: 20)
    quantity = args.quantity.to_i
    @result.sample(quantity).each do |result|

      # 處理種類
      case result['animal_kind']
      when '狗'
        result['animal_kind'] = "狗狗"
      when '貓'
        result['animal_kind'] = "貓貓"
      end

      # 處理性別
      case result['animal_sex']
      when 'M'
        result['animal_sex'] = "男生"
      when 'F'
        result['animal_sex'] = "女生"
      when 'N'
        result['animal_sex'] = "性別未知"
      end

      # 處理年紀
      case result['animal_age']
      when 'ADULT'
        result['animal_age'] = "成年"
      when 'CHILD'
        result['animal_age'] = "幼年"
      when ''
        result['animal_age'] = "年紀未知"
      end

      # 處理是否絕育
      case result['animal_sterilization']
      when 'T'
        result['animal_sterilization'] = "已結紮"
      when 'F'
        result['animal_sterilization'] = "未結紮"
      when 'N'
        result['animal_sterilization'] = "未知"
      end

      # 處理animal_status
      case result['animal_status']
      when 'NONE'
        result['animal_status'] = "未公告"
      when 'OPEN'
        result['animal_status'] = "開放認養"
      when 'ADOPTED'
        result['animal_status'] = "已經認養"
      when 'OTHER'
        result['animal_status'] = "其他"
      when 'DEAD'
        result['animal_status'] = "死亡"
      end

      # 處理adopt_status狀態
      case result['animal_status']
      when '開放認養'
        result['adopt_status'] = "待領養"
      when '已經認養'
        result['adopt_status'] = "已領養"
      else 
        result['adopt_status'] = "未上架"
      end

      # 處理animal_bodytype
      case result['animal_bodytype']
      when 'BIG'
        result['animal_bodytype'] = "大型"
      when 'MEDIUM'
        result['animal_bodytype'] = "中型"
      when 'SMALL'
        result['animal_bodytype'] = "小型"
      end

      # 處理animal_colour
      case result['animal_colour']
      when ''
        result['animal_colour'] = "其他"
      end

      #  處理沒有圖片，判斷貓或狗給預設圖。
      if result['album_file'] == nil || result['album_file'] == "" && result['animal_kind'] == "狗狗"
        result['album_file'] = "https://picsum.photos/id/237/500/500"
      elsif result['album_file'] == nil || result['album_file'] == "" && result['animal_kind'] == "貓貓"
        result['album_file'] = "https://picsum.photos/id/40/500/500"
      else
      result['album_file']
      end

      # 判斷是要更新或新增寵物
      if Animal.find_by(animal_subid: result['animal_subid'])
        animal_data = Animal.find_by(animal_subid: result['animal_subid'])
        
        unless animal_data.animal_id == result['animal_id']
          animal_data.assign_attributes( animal_subid: result['animal_id'] )
        end
        unless animal_data.animal_subid == result['animal_subid']
          animal_data.assign_attributes( animal_subid: result['animal_subid'] )
        end
        unless animal_data.animal_area_pkid == result['animal_area_pkid']
          animal_data.assign_attributes( animal_area_pkid: result['animal_area_pkid'] )
        end
        unless animal_data.animal_kind == result['animal_kind']
          animal_data.assign_attributes( animal_kind: result['animal_kind'] )
        end
        unless animal_data.animal_sex == result['animal_sex']
          animal_data.assign_attributes( animal_sex: result['animal_sex'] )
        end
        unless animal_data.animal_age == result['animal_age']
          animal_data.assign_attributes( animal_age: result['animal_age'] )
        end
        unless animal_data.animal_sterilization == result['animal_sterilization']
          animal_data.assign_attributes( animal_sterilization: result['animal_sterilization'] )
        end
        unless animal_data.animal_foundplace == result['animal_foundplace']
          animal_data.assign_attributes( animal_foundplace: result['animal_foundplace'] )
        end
        unless animal_data.animal_status == result['animal_status']
          animal_data.assign_attributes( animal_status: result['animal_status'] )
        end
        unless animal_data.user_id == shelter[result['shelter_name']]
          animal_data.assign_attributes( user_id: shelter[result['shelter_name']] )
        end
        unless animal_data.adopt_status == result['adopt_status']
          animal_data.assign_attributes( adopt_status: result['adopt_status'] )
        end
        unless animal_data.animal_bodytype == result['animal_bodytype']
          animal_data.assign_attributes( animal_bodytype: result['animal_bodytype'] )
        end
        unless animal_data.animal_colour == result['animal_colour']
          animal_data.assign_attributes( animal_colour: result['animal_colour'] )
        end

      else
        animal_data = Animal.new
        animal_data.images.attach(io: open(result['album_file']), filename: "#{result['animal_subid']}.jpg")

        animal_data.assign_attributes(
          animal_id: result['animal_id'],
          animal_subid: result['animal_subid'],
          animal_area_pkid: result['animal_area_pkid'],
          animal_kind: result['animal_kind'],
          animal_sex: result['animal_sex'],
          animal_age: result['animal_age'],
          animal_sterilization: result['animal_sterilization'],
          animal_foundplace: result['animal_foundplace'],
          animal_status: result['animal_status'],
          user_id: shelter[result['shelter_name']],
          adopt_status: result['adopt_status'],
          animal_bodytype: result['animal_bodytype'],
          animal_colour: result['animal_colour'],
          gov_shelter: true
        )
      end

      animal_data.save
      # 對應寵物id跟圖
      puts "id: #{animal_data.id}"
      puts "subid: #{animal_data.animal_subid}"
      puts "subid: #{animal_data.animal_id}"
      puts "#{result['album_file']}"
      end
      puts "Finish!!!"
  end
end