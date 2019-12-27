desc "build data for reservation feature"
task :res_test => :environment do 
  Animal.create(name: '黃黃2', animal_kind: '貓', animal_sex: '公', animal_age: '成年', animal_sterilization: '是', animal_foundplace: '基隆港', animal_status: '開放認養', animal_area_pkid: '基隆市', animal_subid:'EAAAG0000000001', user_id: '1')  
  Animal.create(name: '黃黃3', animal_kind: '貓', animal_sex: '公', animal_age: '成年', animal_sterilization: '是', animal_foundplace: '基隆港', animal_status: '開放認養', animal_area_pkid: '基隆市', animal_subid:'EAAAG0000000001', user_id: '1')  
  Animal.create(name: '黃黃4', animal_kind: '貓', animal_sex: '公', animal_age: '成年', animal_sterilization: '是', animal_foundplace: '基隆港', animal_status: '開放認養', animal_area_pkid: '基隆市', animal_subid:'EAAAG0000000001', user_id: '1')

  Favorite.create(user_id: '33', animal_id:'1')
  Favorite.create(user_id: '33', animal_id:'2')
  Favorite.create(user_id: '33', animal_id:'3')
  Favorite.create(user_id: '33', animal_id:'4')
  Favorite.create(user_id: '33', animal_id:'5')
  Favorite.create(user_id: '33', animal_id:'6')
  Favorite.create(user_id: '33', animal_id:'7')
  Favorite.create(user_id: '33', animal_id:'8')
  Favorite.create(user_id: '33', animal_id:'9')
  Favorite.create(user_id: '33', animal_id:'10')
  Favorite.create(user_id: '33', animal_id:'11')
end