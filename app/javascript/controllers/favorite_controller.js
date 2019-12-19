
import { Controller } from "stimulus"
import axios from 'axios' 

export default class extends Controller {
  static targets = [ "output" ]

  connect() {
    this.outputTarget.textContent = 'Hello, Stimulus!'
  }

  toggle(evt){
		evt.preventDefault()
		axios.post('/api/animals/2/favorite')
	  	.then(function(response){
	    	console.log(response.data)
	  	})
	   	.catch(function(error){
	    	console.log(error)
	  	})
}


}
