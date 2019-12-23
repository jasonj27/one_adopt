// data-cotroller = "favorite"  //favorite_controller.js
// data-target = "favorite.output" //favorite_controller的output
// data-action  //<a href="#" data-action="favorite#pushme">按我</>


import { Controller } from "stimulus"
import axios from 'axios' 

export default class extends Controller {
  static targets = [ "icon" ]



  toggle(evt){
  	evt.preventDefault() //預設<a>連結停下來,不再轉頁


 		const token = document.querySelector("meta[name=csrf-token]")||{ content: 'no-csrf-token'}

		var ax = axios.create({  //搜尋axios head common的寫法
		 headers: {
		    common: {
		      'X-CSRF-TOKEN': token.content
		    }
		  }
		})



  	let id = this.data.get('id')
  	let icon = this.iconTarget

 		ax.post(`/api/animals/${id}/favorite`,{})

 			.then(function(response){
 				let favorited = response.data.favorited

 				if(favorited){
 					icon.classList.remove('far')
 					icon.classList.add('fas')
 				}else{
 					icon.classList.remove('fas')
 					icon.classList.add('far')
 				}
 			})
 			.catch(function(error){
 				console.log(error)  //什麼情況會error?
 			})
 			// return  ax.post
  }
}


