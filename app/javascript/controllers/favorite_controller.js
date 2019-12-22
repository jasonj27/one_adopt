// data-cotroller = "favorite"  //favorite_controller.js
// data-target = "favorite.output" //favorite_controller的output
// data-action  //<a href="#" data-action="favorite#pushme">按我</>


import { Controller } from "stimulus"
import axios from 'axios' 

export default class extends Controller {
  static targets = [ "icon" ]



  toggle(evt){
  	evt.preventDefault() //預設<a>連結停下來,不再轉頁


  	console.log(this.element.dataset['animalid'])
  	//newfav data-favorite-id已抓不到
  	// 影片時間在15:45



 		const token = document.querySelector("meta[name=csrf-token]")||{ content: 'no-csrf-token'}

		var ax = axios.create({  //搜尋axios head common的寫法
		 headers: {
		    common: {
		      'X-CSRF-TOKEN': token.content
		    }
		  }
		})


 		ax.post(`/api/animals/${id}/favorite`,{})
 			.then(function(response){
 				console.log(response)
 			})
 			.catch(function(error){
 				console.log(error)
 			})
  }
}


// let icon = this.iconTarget
// if (icon.classList.contains("fas")){
//   		icon.classList.remove("fas")
//   		icon.classList.add("far")
// }else{
//   		icon.classList.remove("far")
//   		icon.classList.add("fas")
// }
