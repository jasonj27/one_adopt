import $ from "jquery"
import 'bootstrap'

document.addEventListener("DOMContentLoaded", function() {
  function getImg(){
    let lat = $('#latitude').val()
    let lng = $('#longitude').val()
    return `https://maps.googleapis.com/maps/api/staticmap?center=${lat},${lng}&zoom=18&size=400x250&scale=2&maptype=roadmap&markers=color:red|${lat},${lng}&key=AIzaSyDkzbhgrcZprbdEP9aU0GqRTuKdG9r2zAg`
  }
  if ("geolocation" in navigator){
    $('#distance').on("change", function(){
      let watchID = navigator.geolocation.watchPosition(function(position) {
        console.log(position.coords.latitude, position.coords.longitude)
        $('#latitude').val(position.coords.latitude)
        $('#longitude').val(position.coords.longitude)
        $('#locationButton').attr("disabled", false)
        let imgUrl = getImg()
        let insertBody = `<div class=""><div>您的位置：</div><img src=\"${imgUrl}\" style="width: 100%;"></div>`
        $('.modal-body').html(insertBody)
      },
      ()=>{},
      {enableHighAccuracy: true, timeout: 10000})
      if ($('#latitude').val() === "" || $('#longitude').val() === ""){
        $('#locationButton').attr("disabled", true)
        $('#locationModal').modal('show')
      }
    })
  }else{
    alert("無法取得位置")
  }
})