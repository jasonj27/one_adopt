import $ from "jquery";
import "../picker/index.js";

document.addEventListener("turbolinks:load", function() {
  let myvar = $("#timepicker").pickatime({
    interval: 30
  });
  let picker = myvar.pickatime("picker");

  let date = $(".available-date").data("time");

  $("#datepicker").pickadate({
    min: true,
    container: '#date',
    firstDay: 1,
    disable: [true, ...date],
    onSet: function() {
      $(".available-time").removeClass("active");
      let date = new Date($("#datepicker").val());
      switch (date.getDay()) {
        case 0:
          $("#w0").addClass("active");
          break;
        case 1:
          $("#w1").addClass("active");
          break;
        case 2:
          $("#w2").addClass("active");
          break;
        case 3:
          $("#w3").addClass("active");
          break;
        case 4:
          $("#w4").addClass("active");
          break;
        case 5:
          $("#w5").addClass("active");
          break;
        case 6:
          $("#w6").addClass("active");
          break;
      }
      let enable = $(".active").data("time");
      console.log(enable);
      picker
        .set("enable", true)
        .set("disable", enable)
        .set("enable", "flip");
    }
  });
});
