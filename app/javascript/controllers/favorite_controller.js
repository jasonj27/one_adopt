import { Controller } from "stimulus"
import axios from 'axios' 

export default class extends Controller {
  static targets = [ "icon" ]

   connect() {
    this.favorited = this.data.get('favorited');
  }

  toggle(evt){
    evt.preventDefault()
    const token = document.querySelector("meta[name=csrf-token]")||{ content: 'no-csrf-token'}

    var ax = axios.create({ 
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
        console.log(error)
      })
  }
  set favorited(value) {
    this.data.set('favorited', value.toString());
    this.updateIcon();
  }

  updateIcon() {
    this.iconTarget.classList.toggle('fas', this.data.get('favorited') === 'true')
  }
}