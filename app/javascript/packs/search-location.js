import $ from "jquery"
import 'bootstrap'
import loadGoogleMapsApi from 'load-google-maps-api/index'

document.addEventListener("DOMContentLoaded", function() {
  loadGoogleMapsApi({key: 'AIzaSyDkzbhgrcZprbdEP9aU0GqRTuKdG9r2zAg'}).then(function(googleMaps){
    let map
    let infoWindow

    map = new googleMaps.Map(document.getElementById('map'), {
      center: {
        lat: 25.0424356, 
        lng: 121.5137072
      },
        zoom: 17,
        disableDefaultUI: true
      })

    infoWindow = new googleMaps.InfoWindow

    function handleLocationError(browserHasGeolocation, infoWindow, pos) {
      infoWindow.setPosition(pos);
      infoWindow.setContent(browserHasGeolocation ?
                            '定位失敗' :
                            '您的瀏覽器不支援定位服務')
      infoWindow.open(map)
      $('#locationButton').attr("disabled", false)
    }
    if ("geolocation" in navigator){
      $('#distance').on("change", function(){
        navigator.geolocation.watchPosition(function(position) {
          console.log(position.coords.latitude, position.coords.longitude)
          let pos = {
            lat: position.coords.latitude,
            lng: position.coords.longitude
          }
          infoWindow.setPosition(pos)
          infoWindow.setContent('您的位置')
          infoWindow.open(map)
          map.setCenter(pos)
          $('#latitude').val(pos.lat)
          $('#longitude').val(pos.lng)
          $('#locationButton').attr("disabled", false)
        },
        ()=>{handleLocationError(true, infoWindow, map.getCenter())},
        {enableHighAccuracy: true, timeout: 10000})
        if ($('#latitude').val() === "" || $('#longitude').val() === ""){
          $('#locationButton').attr("disabled", true)
          $('#locationModal').modal('show')
        }
      })
      }else{
        handleLocationError(false, infoWindow, map.getCenter())
      }

    }).catch(function (error) {
      console.error(error)
    })
})