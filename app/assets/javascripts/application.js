// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-readyselector
//= require jquery-ui/sortable
//= require jquery-ui/draggable
//= require jquery-ui/droppable
//= require jquery-ui/selectable
//= require bootstrap-sprockets
//= require metisMenu.min
//= require bootstrap-toggle.min
//= require bootstrap-datepicker
//= require isotope/dist/isotope.pkgd.min
//= require isotope-cells-by-row/cells-by-row
//= require dropzone/dist/min/dropzone.min
//= require unveil/jquery.unveil.min
//= require html5lightbox.js
//= require bootstrap3-dialog/dist/js/bootstrap-dialog.min
//= require bootstrap-select/dist/js/bootstrap-select
//= require spin
//= require jquery.spin
//= require jquery.slimscroll.min
//= require jquery.loadTemplate.min
//= require jsrender.min
//= require remarkable-bootstrap-notify/bootstrap-notify.min
//= require 'icheck'
//= require bootstrap-timepicker/js/bootstrap-timepicker
//= require validator
//= require moment
//= require_tree ./pages
//= require_tree .

$(function() {
  $('#side-menu').metisMenu({});

  //page:load cuz turbolinks
  $(window).bind("load page:load resize", function() {
      topOffset = 50;
      width = (this.window.innerWidth > 0) ? this.window.innerWidth : this.screen.width;
      if (width < 768) {
          $('div.navbar-collapse').addClass('collapse');
          topOffset = 100; // 2-row-menu
      } else {
          $('div.navbar-collapse').removeClass('collapse');
      }

      height = ((this.window.innerHeight > 0) ? this.window.innerHeight : this.screen.height) - 1;
      height = height - topOffset;
      if (height < 1) height = 1;
      if (height > topOffset) {
          $("#page-wrapper").css("min-height", (height) + "px");
          // .css("height", (height) + "px");
          $('.page-content').css("min-height", height-100 + "px");
      }
  });

  var url = window.location;
  var element = $('ul.nav a').filter(function() {
      return this.href == url || url.href.indexOf(this.href) == 0;
  }).addClass('active').parent().parent().addClass('in').parent();
  if (element.is('li')) {
      element.addClass('active');
  }
});

// debounce so filtering doesn't happen every millisecond
function debounce( fn, threshold ) {
  var timeout;
  return function debounced() {
    if ( timeout ) {
      clearTimeout( timeout );
    }
    function delayed() {
      fn();
      timeout = null;
    }
    timeout = setTimeout( delayed, threshold || 100 );
  }
}

//-- Converting number to formatted duration output
Number.prototype.toHHMMSS = function () {
  var sec_num = parseInt(this, 10); // don't forget the second param
  var hours   = Math.floor(sec_num / 3600);
  var minutes = Math.floor((sec_num - (hours * 3600)) / 60);
  var seconds = sec_num - (hours * 3600) - (minutes * 60);

  if (hours   < 10) {hours   = "0"+hours;}
  if (minutes < 10) {minutes = "0"+minutes;}
  if (seconds < 10) {seconds = "0"+seconds;}
  // var time    = hours+':'+minutes+':'+seconds;
  var time    = minutes+':'+seconds;
  return time;
}

//-- Converting string to formatted duration output
String.prototype.toHHMMSS = function () {
  var sec_num = parseInt(this, 10); // don't forget the second param
  var hours   = Math.floor(sec_num / 3600);
  var minutes = Math.floor((sec_num - (hours * 3600)) / 60);
  var seconds = sec_num - (hours * 3600) - (minutes * 60);

  if (hours   < 10) {hours   = "0"+hours;}
  if (minutes < 10) {minutes = "0"+minutes;}
  if (seconds < 10) {seconds = "0"+seconds;}
  var time    = hours+':'+minutes+':'+seconds;
  return time;
}

//-- Used for setting up custom checkboxes
function icheck(){
  if($(".sf-checkbox").length > 0){
    $(".sf-checkbox").each(function(){
      var $el = $(this);
      var skin = ($el.attr('data-skin') !== undefined) ? "_" + $el.attr('data-skin') : "",
      color = ($el.attr('data-color') !== undefined) ? "-" + $el.attr('data-color') : "";
      var opt = {
        checkboxClass: 'icheckbox' + skin + color,
        radioClass: 'iradio' + skin + color,
      }
      $el.iCheck(opt);
    });
  }
}

$(function(){
  icheck();
})