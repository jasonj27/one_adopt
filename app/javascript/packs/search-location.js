document.addEventListener("DOMContentLoaded", function() {
  if ("geolocation" in navigator){
    $('#distance').on("change", function(){
      let watchID = navigator.geolocation.watchPosition(function(position) {
        console.log(position.coords.latitude, position.coords.longitude)
        $('#latitude').val(position.coords.latitude)
        $('#longitude').val(position.coords.longitude)
      },
      ()=>{},
      {enableHighAccuracy: true, timeout: 10000})
    })
  }else{
    alert("無法取得位置")
  }
})