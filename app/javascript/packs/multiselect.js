import $ from "jquery";
// import '../multiselect/jquery.multiselect.js'
import "../multiselect/jquery.multiselect.css";

$.fn.multiSelect = function(options) {
  // Default options
  var settings = $.extend(
    {
      label: "Select"
    },
    options
  );

  var wrap = this,
    selectEl = wrap.children("select"),
    inputEl = wrap.children("input");

  var mainEl = $("<div></div>").addClass("multiselect-wrap"),
    selectedEl = $("<div></div>")
      .addClass("multiselect-selected")
      .text(settings.label),
    listEl = $("<div></div>")
      .addClass("multiselect-list")
      .css("display", "none");

  selectEl.find("option").each(function() {
    var option = $(this);
    var optionEl = $("<div></div>")
      .text(option.text())
      .attr("data-val", option.val());
    optionEl.appendTo(listEl);

    optionEl.on("click", function() {
      $(this).toggleClass("selected-option");

      selectedEl.empty();
      var selectedVal = [];
      listEl.find(".selected-option").each(function() {
        var $this = $(this),
          span = $("<span></span>").text($this.text());
        span.appendTo(selectedEl);

        selectedVal.push($this.attr("data-val"));
      });

      if (inputEl.length > 0) {
        inputEl.val(selectedVal.join(","));
      }
    });
  });

  selectedEl.on("click", function() {
    if (listEl.hasClass("multi-list-opened")) {
      listEl.slideUp(function() {
        listEl.removeClass("multi-list-opened");
      });
    } else {
      listEl.slideDown(function() {
        listEl.addClass("multi-list-opened");
      });
    }
  });
  mainEl.append(selectedEl).append(listEl);
  wrap.append(mainEl);
  selectEl.hide();

  $("html").click(function(e) {
    if (
      !$(e.target).is(wrap) &&
      !$(e.target).is(listEl) &&
      !$(e.target).is(selectedEl) &&
      !$(e.target).is(mainEl) &&
      !$(e.target).is(listEl.children()) &&
      !$(e.target).is(selectedEl.children())
    ) {
      if (listEl.hasClass("multi-list-opened")) {
        // console.log("html event");
        listEl.slideUp(function() {
          listEl.removeClass("multi-list-opened");
        });
      }
    }
  });
  if (inputEl.val() !== "") {
    let selectedVal = inputEl.val().split(",");
    this.find(".multiselect-selected").empty();

    selectedVal.forEach(x => {
      selectEl.find("option").each(function() {
        let myOption = $(this);
        if (x === myOption.val())
          wrap
            .find(".multiselect-selected")
            .append(`<span>${myOption.html()}</span>`);
        let myList = wrap.find(".multiselect-list");
        myList.find("div").each(function() {
          if (x === $(this).attr("data-val")) {
            $(this).addClass("selected-option");
          }
        });
      });
    });
    
  }
  return this;
};

document.addEventListener("turbolinks:load", function() {
  $("#days-select").multiSelect({
    label: "請選擇星期"
  });
  $("#w1-select").multiSelect({
    label: "請選擇星期一的時間"
  });
  $("#w2-select").multiSelect({
    label: "請選擇星期二的時間"
  });
  $("#w3-select").multiSelect({
    label: "請選擇星期三的時間"
  });
  $("#w4-select").multiSelect({
    label: "請選擇星期四的時間"
  });
  $("#w5-select").multiSelect({
    label: "請選擇星期五的時間"
  });
  $("#w6-select").multiSelect({
    label: "請選擇星期六的時間"
  });
  $("#w0-select").multiSelect({
    label: "請選擇星期日的時間"
  });
});
