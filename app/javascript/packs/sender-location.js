import axios from "axios"
import $ from "jquery"

document.addEventListener("DOMContentLoaded", function() {
  function showImg(){
    let lat = $('#user_latitude').val()
    let lng = $('#user_longitude').val()
    let imgurl = `https://maps.googleapis.com/maps/api/staticmap?center=${lat},${lng}&zoom=18&size=400x250&scale=2&maptype=roadmap&markers=color:red|${lat},${lng}&key=AIzaSyDkzbhgrcZprbdEP9aU0GqRTuKdG9r2zAg`
    $('#location-img').attr('src', `${imgurl}`).css('width', '100%')
  }

  $('#get-location').on('click', e => {
    e.preventDefault()
    e.stopPropagation()
    let add = $('#user_sender_area').val()+$('#user_sender_add').val()
    axios.get(`https://maps.googleapis.com/maps/api/geocode/json?address=${add}&key=AIzaSyDkzbhgrcZprbdEP9aU0GqRTuKdG9r2zAg`)
         .then(res=>{return res.data.results[0].geometry.location})
         .then((location)=>{
          console.log(location)
          $('#user_latitude').val(location.lat)
          $('#user_longitude').val(location.lng)
          showImg()
          $('.map').show()
         })
         .catch(err=>console.log(err))
    alert('您的位置如下圖所標示')
  })

  if ($('#user_latitude').val()!=="" && $('#user_longitude').val()!==""){
    $('#get-location').html('更新我的地址位置')
    showImg()
  }else{
    $('.map').hide()
  }
})
