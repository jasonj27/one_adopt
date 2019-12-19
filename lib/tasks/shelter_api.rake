namespace :access do
  desc "Grab Animals data and Parse Json"
  task shelter_api: :environment do
    require 'JSON'
    require 'open-uri'
    require 'net/http'

    url = 'http://data.coa.gov.tw/Service/OpenData/TransService.aspx?UnitId=QcbUEzN6E6DL'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    @result = JSON.parse(response)

    shelter = User.where("email ILIKE :email", email: "%pet.com").map{  |x| { x.name => x.id } }.inject(:merge)

    @result.each do |result|
      case result['animal_sterilization']
      when 'T'
        result['animal_sterilization'] = "TT"
      when 'F'
        result['animal_sterilization'] = "FF"
      else 'N'
        result['animal_sterilization'] = "NN"
      end
      User.last.class
      # result.images.attach(io: open(result['album_file']), filename: "#{result['animal_subid']}.jpg")
      result.images.attach(io: open(result['album_file']), filename: "#{result['animal_subid']}.jpg")

      # a5 = Animal.find(5)
      # a5.images.attach(io: open(result['album_file']), filename: "#{result['animal_subid']}.jpg")

      # if result['album_file'] == ""
      #   # 給假圖
      #   result['album_file'] = "https://fakeimg.pl/350x200/?text=NoPic"
      #   # 存到本地
      #   result.images.attach(io: open(result['album_file']), filename: "#{result['animal_subid']}.jpg")
      # else
      #   # 存到本地
      #   result.images.attach(io: open(result['album_file']), filename: "#{result['animal_subid']}.jpg")
      # end


      
      a = Animal.create(
        animal_subid: result['animal_subid'],
        animal_area_pkid: result['animal_area_pkid'],
        animal_kind: result['animal_kind'],
        animal_sex: result['animal_sex'],
        animal_age: result['animal_age'],
        animal_sterilization: result['animal_sterilization'],
       
        animal_foundplace: result['animal_foundplace'],
        # album_file: result['album_file'],
        user_id: shelter[result['shelter_name']]
        # on_sell: true
         
      )
      a.album_file.attach(io: open('http://asms.coa.gov.tw/amlapp/upload/pic/3e694abe-62f2-44fd-84f6-5c7f435ba3b2_org.JPG'), filename: "testtest.jpg")

      
    end
  end
end


