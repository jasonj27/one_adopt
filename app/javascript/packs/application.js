require("@rails/ujs").start()
// require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import '../scripts/index.js'
import '../stylesheets/index.js'
import 'jquery'
import "controllers"

const images = require.context("../images", true)
const imagePath = (name) => images(name, true)

require("trix")
require("@rails/actiontext")
import './trix-overrides.js'

import axios from "axios"

document.addEventListener("DOMContentLoaded", function() {
  $('#get-location').on('click', e => {
    e.preventDefault()
    e.stopPropagation()
    let add = $('#user_sender_area').val()+$('#user_sender_add').val()
    axios.get(`https://maps.googleapis.com/maps/api/geocode/json?address=${add}&key=AIzaSyDkzbhgrcZprbdEP9aU0GqRTuKdG9r2zAg`)
         .then(res=>{return res.data.results[0].geometry.location})
         .then((location)=>{
          console.log(location)
          $('#user_latitude').val(location.lat)
          $('#user_longtitude').val(location.lng)
          let imgurl = `https://maps.googleapis.com/maps/api/staticmap?center=${location.lat},${location.lng}&zoom=18&size=400x250&scale=2&maptype=roadmap&markers=color:red|${location.lat},${location.lng}&key=AIzaSyDkzbhgrcZprbdEP9aU0GqRTuKdG9r2zAg`
          $('#location-img').attr('src', `${imgurl}`).css('width', '400px').css('height', '250px')
         })
         .catch(err=>console.log(err))
    alert('您的位置如下圖所標示')
  })
})